pragma solidity >=0.4.22 <0.6.0;

import "../Organ.sol";

/**

Kelsen Framework
Procedure library
This library is used to hold the logic common to all procedures

**/
library propositionVotingLibrary {
  
    struct VotingProcessInfo 
    {
        uint quorumSize;
        uint votingPeriodDuration;
        uint promulgationPeriodDuration;
        uint majoritySize;
        uint nextPropositionNumber;
        // Mapping to track user participation
        mapping(address => uint256) userParticipation;
        mapping(uint => Proposition) propositions;
    }

        // Proposition structure
    struct Proposition 
    {
        //Authorization bools
        bool canAdd;  // if true, Admin can add norms
        bool canDelete;  // if true, Admin can delete norms
        bool canSpend;
        bool canDeposit;
        // Counting bools
        bool wasVetoed;
        bool wasCounted;
        bool wasAccepted;
        bool wasEnded;
        uint8 hash_function;
        uint8 size;
        // Proposition type typonomy
        // 0: Add master
        // 1: Remove master
        // 2: Replace master
        // 3: Add admin
        // 4: Remove admin
        // 5: Replace admin
        // 6: Add norm
        // 7: Remove norm. In this case, the norm to be removed must be designated by its NUMBER, encoded in hex in the contractToRemove field.
        // 8: Replace norm. In this case, the norm to be replaced must be designated by its NUMBER, encoded in hex in the contractToRemove field.
        // If the proposition is a payout proposition, the propositionType field is used to specify the desired payout. 
        // In this case it needs to be processed with the processPayoutPropositionLib() function
        uint propositionType;
        bytes32 ipfsHash; // ID of proposal on IPFS
        
        uint votingPeriodEndDate;
        uint voteFor;
        // uint voteAgainst;
        uint totalVoteCount;
        uint propositionNumber;
        // Proposition details
        address payable targetOrgan;
        address payable contractToAdd;
        address contractToRemove;
    }

    // Events

    event createPropositionEvent(address _from, address _targetOrgan, uint _propositionType, uint _propositionNumber, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size);
    event createPropositionDetails(address _contractToAdd, address _contractToRemove);
    event createMasterPropositionEvent(uint _propositionNumber, bool _canAdd, bool _canDelete);
    event createAdminPropositionEvent(uint _propositionNumber, bool _canAdd, bool _canDelete, bool _canDeposit, bool _canSpend);
    event voteOnProposition(address _from, uint _propositionNumber);
    event vetoProposition(address _from, uint _propositionNumber);
    event countVotes(address _from, uint _propositionNumber);
    event promulgatePropositionEvent(address _from, uint _propositionNumber, bool _promulgate);


    function initElectionParameters(VotingProcessInfo storage self, uint _quorumSize, uint _votingPeriodDuration, uint _promulgationPeriodDuration, uint _majoritySize)
    public
    {
        self.quorumSize = _quorumSize;
        self.votingPeriodDuration = _votingPeriodDuration;
        self.promulgationPeriodDuration = _promulgationPeriodDuration;
        self.majoritySize = _majoritySize;
    }

    function getBoolean(uint256 _packedBools, uint256 _boolNumber)
    public 
    pure 
    returns(bool)
    {
        uint256 flag = (_packedBools >> _boolNumber) & uint256(1);
        return (flag == 1 ? true : false);
    }

    function setBoolean(uint256 _packedBools, uint256 _boolNumber, bool _value) 
    public 
    pure 
    returns(uint256) 
    {
        if (_value)
            return _packedBools | uint256(1) << _boolNumber;
        else
            return _packedBools & ~(uint256(1) << _boolNumber);
    }

        /// Create a new ballot to choose one of `proposalNames`.
    function createPropositionLib(VotingProcessInfo storage self, address payable _targetOrgan, address payable _contractToAdd, address _contractToRemove, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size, bool _canAdd, bool _canDelete, bool _canDeposit, bool _canSpend, uint _propositionType) 
    public 
    returns (uint propositionNumber)
    {
        // Retrieving proposition number
        propositionNumber = self.nextPropositionNumber;

        self.propositions[propositionNumber].targetOrgan = _targetOrgan;
        self.propositions[propositionNumber].contractToAdd = _contractToAdd;
        self.propositions[propositionNumber].contractToRemove = _contractToRemove;
        self.propositions[propositionNumber].ipfsHash = _ipfsHash;
        self.propositions[propositionNumber].hash_function = _hash_function;
        self.propositions[propositionNumber].size = _size;
        self.propositions[propositionNumber].canAdd = _canAdd;
        self.propositions[propositionNumber].canDelete = _canDelete;
        self.propositions[propositionNumber].canSpend = _canSpend;
        self.propositions[propositionNumber].canDeposit = _canDeposit;
        self.propositions[propositionNumber].propositionType = _propositionType;
        self.propositions[propositionNumber].votingPeriodEndDate = now + self.votingPeriodDuration;            
        self.propositions[propositionNumber].wasVetoed = false;
        self.propositions[propositionNumber].wasEnded = false;
        self.propositions[propositionNumber].wasCounted = false;
        self.propositions[propositionNumber].wasAccepted = false;
        self.propositions[propositionNumber].totalVoteCount = 0;
        self.propositions[propositionNumber].voteFor = 0;
        self.propositions[propositionNumber].propositionNumber = propositionNumber;

        self.nextPropositionNumber += 1;

        // proposition creation event
        emit createPropositionEvent(msg.sender, _targetOrgan, _propositionType, propositionNumber, _ipfsHash, _hash_function, _size);
        emit createPropositionDetails(_contractToAdd, _contractToRemove);
        if (_propositionType < 3)
        {
            // Master proposition event
            emit createMasterPropositionEvent(propositionNumber, _canAdd, _canDelete);
        }
        else if (_propositionType > 2 && _propositionType < 6)
        {
            // Admin proposition event
            emit createAdminPropositionEvent(propositionNumber, _canAdd, _canDelete, _canDeposit, _canSpend);
        }
    }

        /// Vote for a proposition
    function voteLib(VotingProcessInfo storage self, Proposition storage proposition, bool _acceptProposition) 
    public 
    {
        // Check if voter already voted
        require(!getBoolean(self.userParticipation[msg.sender], proposition.propositionNumber));

        // Check if vote is still active
        require(!proposition.wasCounted);

        // Check if voting period ended
        require(proposition.votingPeriodEndDate > now);

        // Adding vote
        if(_acceptProposition == true)
        {
            proposition.voteFor += 1;
        }

        // Loggin that user voted
        setBoolean(self.userParticipation[msg.sender], proposition.propositionNumber, true);

        // Adding vote count
        proposition.totalVoteCount += 1;

        // create vote event
        emit voteOnProposition(msg.sender, proposition.propositionNumber);
    }

        /// Vote for a candidate
    function vetoLib(Proposition storage proposition) 
    public 
    {
        // Check if vote is still active
        require(!proposition.wasCounted);

        // Check if voting period ended
        require(proposition.votingPeriodEndDate > now);

        // Log that proposition was vetoed
        proposition.wasVetoed = true;

        //  Create veto event
        emit vetoProposition(msg.sender, proposition.propositionNumber);
    }

    function endPropositionVoteLib(VotingProcessInfo storage self, Proposition storage proposition, address payable votersOrganAddress) 
    public 
    returns (bool hasBeenAccepted) 
    {
        // We check if the vote was already counted
        require(!proposition.wasCounted);

        // Checking that the vote can be closed
        require(proposition.votingPeriodEndDate < now);

        // Checking that the proposition has been initialised
        require(proposition.votingPeriodEndDate != 0);

        Organ voterRegistryOrgan = Organ(votersOrganAddress);
        ( ,uint voterNumber) = voterRegistryOrgan.organInfos();

        // We check that Quorum was obtained and that a majority of votes were cast in favor of the proposition
        if (proposition.wasVetoed)
            {hasBeenAccepted=false;
                proposition.wasEnded = true;}
        else if
            ((proposition.totalVoteCount*100 >= self.quorumSize*voterNumber) && (proposition.voteFor*100 > proposition.totalVoteCount*self.majoritySize))
            {hasBeenAccepted = true;}
        else 
            {hasBeenAccepted=false;
            proposition.wasEnded = true;}


        // ############## Updating ballot values if vote concluded
        proposition.wasCounted = true;
        proposition.wasAccepted = hasBeenAccepted;

        emit countVotes(msg.sender, proposition.propositionNumber);

        return hasBeenAccepted;
    }

    function promulgatePropositionLib(Proposition storage proposition, bool _promulgate) 
    public 
    {
        // Checking if ballot was already enforced
        require(!proposition.wasEnded );

        // Checking the ballot was counted
        require(proposition.wasCounted);

        // Checking the ballot was accepted
        require(proposition.wasAccepted);

        // Checking if the promulgator is chosing to invalidate the proposition
        if (!_promulgate)
        {
            // The promulgator choses to invalidate the promulgation
            proposition.wasEnded = true;
            emit promulgatePropositionEvent(msg.sender, proposition.propositionNumber, _promulgate);
            return;
        }

        // If were are manipulating admin/masters, verify that at contractToRemove and contractToAdd are not both empty
        if (proposition.propositionType < 6)
        {
            require((proposition.contractToAdd != address(0)) || (proposition.contractToRemove != address(0))); 
        }

         // We initiate the Organ interface to add a norm / Admin / master
        Organ affectedOrgan = Organ(proposition.targetOrgan);

        // Adding a master
        if (proposition.propositionType == 0)
        {
            affectedOrgan.addMaster(proposition.contractToAdd, proposition.canAdd, proposition.canDelete);
        }
        // Removing a master
        else if (proposition.propositionType == 1)
        {
            affectedOrgan.remMaster(proposition.contractToRemove);
        }
        // Replacing a master
        else if (proposition.propositionType == 2)
        {
            affectedOrgan.replaceMaster(proposition.contractToRemove, proposition.contractToAdd, proposition.canAdd, proposition.canDelete);
        }
        // Adding an admin
        else if (proposition.propositionType == 3)
        {
            affectedOrgan.addAdmin(proposition.contractToAdd, proposition.canAdd, proposition.canDelete, proposition.canDeposit, proposition.canSpend);
        }
        // Removing an admin
        else if (proposition.propositionType == 4)
        {
            affectedOrgan.remAdmin(proposition.contractToRemove);
        }
        // Replacing an admin
        else if (proposition.propositionType == 5)
        {
            affectedOrgan.replaceAdmin(proposition.contractToRemove, proposition.contractToAdd, proposition.canAdd, proposition.canDelete, proposition.canDeposit, proposition.canSpend);
        }
        // Adding a norm
        else if (proposition.propositionType == 6)
        {
            affectedOrgan.addNorm(proposition.contractToAdd, proposition.ipfsHash, proposition.hash_function, proposition.size );
        }
        // Removing a norm
        else if (proposition.propositionType == 7)
        {
            affectedOrgan.remNorm(uint(proposition.contractToRemove));
        }
        // Replacing a norm
        else if (proposition.propositionType == 8)
        {
            affectedOrgan.replaceNorm(uint(proposition.contractToRemove), proposition.contractToAdd , proposition.ipfsHash, proposition.hash_function, proposition.size);
        }
       
        proposition.wasEnded = true;

        // promulgation event
        emit promulgatePropositionEvent(msg.sender, proposition.propositionNumber, _promulgate);
    }

    function archiveDefunctPropositionLib(Proposition storage proposition) 
    public 
    {
        // Checking that the proposition has been initialised
        require(proposition.votingPeriodEndDate != 0);
        
        // If a proposition contains an instruction that can not be executed (eg "add an admin" without having canAdd enabled), this proposition can be closed

        Organ targetOrganContract = Organ(proposition.targetOrgan);
        bool canAdd;
        bool canDelete;
        if (proposition.propositionType < 6)
        {
            (canAdd, canDelete) = targetOrganContract.isMaster(address(this));
        }
        else 
        {
            (canAdd, canDelete, , ) = targetOrganContract.isAdmin(address(this));
        }
        
        if ((!canAdd && (proposition.contractToAdd != address(0))) || (!canDelete && (proposition.contractToRemove != address(0))) )
        {
            proposition.wasEnded = true;
        }
        emit promulgatePropositionEvent(msg.sender, proposition.propositionNumber, false);
    }

    function processPayoutPropositionLib(Proposition storage proposition, bool _promulgate) 
    public
    {
        // Checking if ballot was already enforced
        require(!proposition.wasEnded );

        // Checking the ballot was counted
        require(proposition.wasCounted);

        // Checking the ballot was accepted
        require(proposition.wasAccepted);

        if ((_promulgate)||((proposition.contractToAdd != address(0)) || (proposition.propositionType != 0)))
        {
            // We initiate the Organ interface to add a norm
            Organ affectedOrgan = Organ(proposition.targetOrgan);
            affectedOrgan.payout(proposition.contractToAdd, proposition.propositionType);
        }

        proposition.wasEnded = true;

        // Promulgation event
        emit promulgatePropositionEvent(msg.sender, proposition.propositionNumber, _promulgate);
    }
}