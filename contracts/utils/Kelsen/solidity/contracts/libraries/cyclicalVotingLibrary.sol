pragma solidity >=0.4.22 <0.6.0;

import "../Organ.sol";

/**

Kelsen Framework
Procedure library
This library is used to hold the logic common to all procedures

**/
library cyclicalVotingLibrary {
  
    struct RecurringElectionInfo 
    {
        uint ballotFrequency;
        // When will the next election take place
        uint nextElectionDate;
        // Time to vote
        uint ballotDuration;
        // Time to declare as a candidate
        uint candidacyDuration;
        // Maximum time someone can be candidate
        uint reelectionMaximum;
        // Minimum participation to validate election
        uint quorumSize;
        // Number of candidate per voter. Not used for many to one election
        uint voterToCandidateRatio;
        // A mapping of candidacy status and number of candidacies per member
        mapping(address => uint) cumulatedMandates;

        // // Is blank vote accepted
        // bool neutralVoteAccepted;
        
        mapping(address => uint) nextElectionUserCanVoteIn;

        // Tracking last candidacies
        mapping(address => Candidacy) candidacies;
    }

    // Candidacies structure, to keep track of candidacies for an election
    struct Candidacy 
    {
        address payable candidateAddress;
        bytes32 ipfsHash; // ID of proposal on IPFS
        uint8 hash_function;
        uint8 size;
        uint voteNumber;
    }

    struct ElectionBallot 
    {
        uint ballotNumber;
        bytes32 name;   // short name (up to 32 bytes)
        uint startDate;
        uint candidacyEndDate;
        uint electionEndDate;
        bool wasEnded;
        uint totalVoteCount;
        uint totalVoters;
        uint electedOfficialSlotNumber;
        address[] candidateList;
    }

    // Events
    event ballotCreationEvent(address _from, bytes32 _name, uint _startDate, uint _candidacyEndDate, uint _endDate, uint _ballotNumber);
    event presentCandidacyEvent(uint _ballotNumber, address _candidateAddress, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size);
    event votedOnElectionEvent(address _from, uint _ballotNumber);
    event ballotWasCounted(uint _ballotNumber, address _winningCandidate, uint _totalVoteCount);
    event ballotResultException(uint _ballotNumber);
    event ballotWasEnforced(address _winningCandidate, uint _ballotNumber);
    event candidateVotesWereCounted(address _countedCandidate, uint _ballotNumber);
    event m2mBallotWasCounted(uint _ballotNumber, uint _totalVoteCount);
    event m2mBallotWasEnforced(address[] _winningCandidates, uint _ballotNumber);

    function initElectionParameters(RecurringElectionInfo storage self, uint _ballotFrequency, uint _ballotDuration, uint _quorumSize, uint _reelectionMaximum, uint _candidacyDuration, uint _voterToCandidateRatio)
    public
    {
        self.ballotFrequency = _ballotFrequency;
        self.nextElectionDate = now;
        self.ballotDuration = _ballotDuration;
        self.quorumSize = _quorumSize;
        self.reelectionMaximum = _reelectionMaximum;
        self.candidacyDuration = _candidacyDuration;
        self.voterToCandidateRatio = _voterToCandidateRatio;
    }

    function createRecurrentBallot(RecurringElectionInfo storage self, ElectionBallot storage ballot, bytes32 _ballotName) 
    public 
    {
        // Checking that election date has passed
        require (now > self.nextElectionDate);
        // Checking if previous ballot was counted
        require(ballot.startDate == 0);
    
        ballot.name = _ballotName;
        ballot.startDate = now;
        ballot.candidacyEndDate = now + self.candidacyDuration;
        ballot.electionEndDate = now + self.candidacyDuration+self.ballotDuration;

        self.nextElectionDate = now + self.ballotFrequency;

        // Ballot creation event
        emit ballotCreationEvent(msg.sender, ballot.name, ballot.startDate, ballot.candidacyEndDate, ballot.electionEndDate, ballot.ballotNumber);
   }

    function presentCandidacyLib(RecurringElectionInfo storage self, ElectionBallot storage ballot, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size) 
    public 
    {
        // Check that the ballot is still active
        require(!ballot.wasEnded);

        // Check that the ballot candidacy period is still open
        require(ballot.candidacyEndDate > now);

        // Check that sender is not over the mandate limit
        require(self.cumulatedMandates[msg.sender] < self.reelectionMaximum);

        // Check if the candidate is already candidate
        require(self.candidacies[msg.sender].candidateAddress != msg.sender);

        ballot.candidateList.push(msg.sender);

        self.candidacies[msg.sender].candidateAddress = msg.sender;

        self.candidacies[msg.sender].ipfsHash = _ipfsHash;
        self.candidacies[msg.sender].hash_function = _hash_function;
        self.candidacies[msg.sender].size = _size;
         // Candidacy event is turned off for now
        emit presentCandidacyEvent(ballot.ballotNumber, msg.sender, _ipfsHash, _hash_function, _size);
    }

    function voteManyToOne(RecurringElectionInfo storage self, ElectionBallot storage ballot, address payable _candidateAddress) 
    public 
    {        
        // Check if voter already votred
        require(self.nextElectionUserCanVoteIn[msg.sender] <= ballot.ballotNumber);

        // Check if vote is still active
        require(!ballot.wasEnded);

        // Check if candidacy period is over
        require(ballot.candidacyEndDate < now);

        // Check if voting period ended
        require(ballot.electionEndDate > now);

        // Check if candidate for whom we voted for is declared
        if(self.candidacies[_candidateAddress].candidateAddress != address(0))
        {self.candidacies[_candidateAddress].voteNumber += 1;}
        else
            // If candidate does not exist, this is a neutral vote
        {self.candidacies[address(0)].voteNumber += 1;}

        self.nextElectionUserCanVoteIn[msg.sender] == ballot.ballotNumber + 1;
        
        ballot.totalVoteCount += 1;

        // Event
        emit votedOnElectionEvent(msg.sender, ballot.ballotNumber);
    }

    function countManyToOne(RecurringElectionInfo storage self, ElectionBallot storage ballot, address payable _votersOrganAddress) 
    public 
    returns (address nextPresidentAddress)
    {
        // We check if the vote was already closed
        require(!ballot.wasEnded);

        // Checking that the vote can be closed
        require(ballot.electionEndDate < now);

        // Checking the ballot has been initialised
        require(ballot.electionEndDate != 0);

        // Checking that there was enough participation
        if ((ballot.candidateList.length == 0) || ballot.totalVoteCount == 0)
        {
            ballot.wasEnded = true;
            emit ballotResultException(ballot.ballotNumber);
            self.nextElectionDate = now -1;
            return address(0);
        }

        // Checking if the election is still valid
        if (now > ballot.startDate + self.ballotFrequency)
        {
            emit ballotResultException(ballot.ballotNumber);
            ballot.wasEnded = true;  
            return address(0);                
        }




        // ############## Going through candidates to check the vote count
        uint winningVoteCount = 0;
        bool isADraw = false;
        bool quorumIsObtained = false;

        Organ voterRegistryOrgan = Organ(_votersOrganAddress);

        // Check if quorum is obtained. We avoiding divisions here, since Solidity is not good to calculate divisions
        ( ,uint voterNumber) = voterRegistryOrgan.organInfos();
        if (ballot.totalVoteCount*100 >= self.quorumSize*voterNumber)
        {
            quorumIsObtained = true;
        }

        delete voterRegistryOrgan;

        // Going through candidates list
        for (uint p = 0; p < ballot.candidateList.length; p++) 
        {
            address _candidateAddress = ballot.candidateList[p];

            // Logging how many votes this candidate received
           emit candidateVotesWereCounted(_candidateAddress, self.candidacies[_candidateAddress].voteNumber);

            if (self.candidacies[_candidateAddress].voteNumber > winningVoteCount) 
            {
                winningVoteCount = self.candidacies[_candidateAddress].voteNumber ;
                delete self.candidacies[nextPresidentAddress];
                nextPresidentAddress = ballot.candidateList[p];
                isADraw = false;
            }

            else if (self.candidacies[_candidateAddress].voteNumber == winningVoteCount)
            {
                isADraw = true;
                // Cleaning candidate info from mapping
                delete self.candidacies[_candidateAddress];
            }

            else
            {   // Cleaning candidate info from mapping
                delete self.candidacies[_candidateAddress];
            }
            
            
        }

        // ############## Updating ballot values if vote concluded
        ballot.wasEnded = true;

        if (!isADraw && quorumIsObtained)
            // The ballot completed succesfully
        {
            emit ballotWasCounted(ballot.ballotNumber, nextPresidentAddress, ballot.totalVoteCount);
        }

        else // The ballot did not conclude correctly.
        {
            emit ballotResultException(ballot.ballotNumber);
            self.nextElectionDate = now -1;
            ballot.wasEnded = true;
            return address(0);
        }

        return nextPresidentAddress;   
    }

    function givePowerToNewPresident(RecurringElectionInfo storage self, ElectionBallot storage ballot, address _newPresident, address _currentPresident, address payable _presidentialOrganAddress)
    public
    {
        Organ presidentialOrgan = Organ(_presidentialOrganAddress);
        presidentialOrgan.addNorm(self.candidacies[_newPresident].candidateAddress, self.candidacies[_newPresident].ipfsHash, self.candidacies[_newPresident].hash_function, self.candidacies[_newPresident].size);
        if (ballot.ballotNumber > 0)
        {
            presidentialOrgan.remNorm(presidentialOrgan.getAddressPositionInNorm(_currentPresident));
        }
        
        emit ballotWasEnforced(_newPresident, ballot.ballotNumber);
    }

    function voteManyToMany(RecurringElectionInfo storage self, ElectionBallot storage ballot, address[] memory _candidateAddresses) 
    public 
    {
        // Check if voter already voted
        require(self.nextElectionUserCanVoteIn[msg.sender] <= ballot.ballotNumber);

        // Check if vote is still active
        require(ballot.wasEnded);

        // Check if candidacy period is over
        require(ballot.candidacyEndDate < now);

        // Check if voting period ended
        require(ballot.electionEndDate > now);

        // Checking that the voter has not selected too much candidates
        require(_candidateAddresses.length < ballot.electedOfficialSlotNumber + 1);
        
        // Checking that the voter selected at least one candidate
        require(_candidateAddresses.length > 0);

        // Going through the list of selected candidates
        for (uint i = 0; i < _candidateAddresses.length; i++)
        {
            if (i > 0)
            {
               require(_candidateAddresses[i-1] < _candidateAddresses[i]); 
            }

            if(self.candidacies[_candidateAddresses[i]].candidateAddress != address(0))
            {
                self.candidacies[_candidateAddresses[i]].voteNumber += ballot.electedOfficialSlotNumber-i;
                ballot.totalVoteCount += ballot.electedOfficialSlotNumber-i;
            }

            else    // If candidate does not exist, this is a neutral vote
            {
                self.candidacies[address(0)].voteNumber += 1;
            }
        }
        self.nextElectionUserCanVoteIn[msg.sender] == ballot.ballotNumber + 1;

        ballot.totalVoters += 1;

        // Log event
        emit votedOnElectionEvent(msg.sender, ballot.ballotNumber);
    }

    function countManyToMany(RecurringElectionInfo storage self, ElectionBallot storage ballot, address[] storage nextModerators, address payable _votersOrganAddress) 
    public 
    {
        // We check if the vote was already closed
        require(!ballot.wasEnded);

        // Checking that the vote can be closed
        require(ballot.electionEndDate < now);

        // Checking the ballot has been initialised
        require(ballot.electionEndDate != 0);

        // Checking that the vote can be closed
        if ((ballot.candidateList.length == 0) || ballot.totalVoteCount == 0)
        {
            self.nextElectionDate = now -1;
            ballot.wasEnded = true;
            emit ballotResultException(ballot.ballotNumber);
            return;
        }

        // Checking that the enforcing date is not later than the end of his supposed mandate
        if (now > ballot.startDate + self.ballotFrequency)
        {
            self.nextElectionDate = now -1;
            ballot.wasEnded = true;
            emit ballotResultException(ballot.ballotNumber);
            return;
        }

        Organ voterRegistryOrgan = Organ(_votersOrganAddress);
        // Check if quorum is obtained. We are avoiding divisions here, since Solidity is not good to calculate divisions
        ( ,uint voterNumber) = voterRegistryOrgan.organInfos();
        if (ballot.totalVoters*100 < self.quorumSize*voterNumber)
        {
            // Quorum was not obtained. Rebooting election
            //ballots[_ballotNumber].wasEnforced = true;
            self.nextElectionDate = now -1;
            ballot.wasEnded = true;

            // Log event
            emit ballotResultException(ballot.ballotNumber);
            // Rebooting election
            //createBallot(ballots[_ballotNumber].name);
            return;
        }
        delete voterRegistryOrgan;

        // Checking that there are enough candidates
        if (ballot.candidateList.length < ballot.electedOfficialSlotNumber)
        {
            ballot.electedOfficialSlotNumber = ballot.candidateList.length;
        } 

        // ############## Going through candidates to check the vote count
        uint previousThresholdCount = uint(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF);
        uint winningVoteCount = 0;
        uint isADraw = 0;
        uint roundWinningCandidate = 0;

        // Going through candidate lists to check all elected moderators
        for (uint i = 0; i < ballot.electedOfficialSlotNumber; i++)
        {
            winningVoteCount = 0;
            roundWinningCandidate = 0;
            // Going through candidate list once to find best suitor
            for (uint p = 0; p < ballot.candidateList.length; p++)
            {
                address _candidateAddress = ballot.candidateList[p];
                if (self.candidacies[_candidateAddress].voteNumber >= previousThresholdCount)
                {}
                else if (self.candidacies[_candidateAddress].voteNumber > winningVoteCount) 
                {
                    winningVoteCount = self.candidacies[_candidateAddress].voteNumber ;
                    roundWinningCandidate = p;
                    isADraw = 0;
                }
                else if (self.candidacies[_candidateAddress].voteNumber == winningVoteCount)
                {
                        isADraw += 1;
                }

            }

            // Checking if various candidates tied
            if (winningVoteCount == 0)
            {}
            else if (isADraw > 0)
            {
                // Going through list one more time to add all tied up candidates
                for (uint q = 0; q < ballot.candidateList.length; q++)
                {   
                    // Making sure that winning candidate number is not too big
                    if (i >= ballot.electedOfficialSlotNumber)
                    {}
                    // Detecting ties
                    else if (self.candidacies[ballot.candidateList[q]].voteNumber == winningVoteCount)
                        {
                            nextModerators.push(ballot.candidateList[q]);
                            i += 1;
                        }
                }
            }
            // Adding candidate to winning candidate list
            else 
            {
                nextModerators.push(ballot.candidateList[roundWinningCandidate]);
            }

            previousThresholdCount = winningVoteCount;
        }

        // ############## Updating ballot values if vote concluded
        ballot.wasEnded = true;
        // Log event
        emit m2mBallotWasCounted(ballot.ballotNumber, ballot.totalVoteCount );
    }

    function enforceManyToMany(RecurringElectionInfo storage self, ElectionBallot storage ballot, address[] storage nextModerators, address[] storage currentModerators, address payable _moderatorsOrganAddress) 
    public 
    {
        // Checking the ballot was closed
        require(ballot.wasEnded);
        
        // Checking there are new moderators to add
        require(nextModerators.length > 0);

        // We initiate the Organ interface to add a moderator norm
        Organ moderatorsOrgan = Organ(_moderatorsOrganAddress);

        // Removing current moderators, if this is not a first election
        if (ballot.ballotNumber > 1)
            {
            for (uint i = 0; i < currentModerators.length; i++)
                {
                    moderatorsOrgan.remNorm(moderatorsOrgan.getAddressPositionInNorm(currentModerators[i]));
                    delete currentModerators[i];
                }
            }

        // Adding new moderators
        for (uint p = 0; p < nextModerators.length; p++)
            {
                Candidacy memory newModerator = self.candidacies[nextModerators[p]];
                moderatorsOrgan.addNorm(newModerator.candidateAddress, newModerator.ipfsHash, newModerator.hash_function, newModerator.size  );
                self.cumulatedMandates[nextModerators[p]] += 1;
                if (p < currentModerators.length )
                {
                    currentModerators[p] = newModerator.candidateAddress;
                }
                else
                {
                    currentModerators.push(newModerator.candidateAddress);
                }
                delete newModerator;
            }

        delete moderatorsOrgan;

        // Cleaning candidate lists and candidatures 
        for (uint k = 0; k < ballot.candidateList.length; k++)
        {
            delete self.candidacies[ballot.candidateList[k]];
        }

        // Logging event
        emit m2mBallotWasEnforced(nextModerators, ballot.ballotNumber);
    }
}