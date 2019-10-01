pragma solidity >=0.4.22 <0.6.0;

// Standard contract for a presidential election procedure

import "../standardProcedure.sol";
import "../Organ.sol";
import "../libraries/cyclicalVotingLibrary.sol";


contract cyclicalManyToManyElectionProcedure is Procedure{
    // 1: Cyclical many to one election (Presidential Election)
    // 2: Cyclical many to many election (Moderators Election)
    // 3: Simple norm nomination 
    // 4: Simple admins and master nomination
    // 5: Vote on Norms 
    // 6: Vote on masters and admins 
    // 7: Cooptation

    using procedureLibrary for procedureLibrary.twoRegisteredOrgans;
    using cyclicalVotingLibrary for cyclicalVotingLibrary.RecurringElectionInfo;
    using cyclicalVotingLibrary for cyclicalVotingLibrary.Candidacy;
    using cyclicalVotingLibrary for cyclicalVotingLibrary.ElectionBallot;

    // First stakeholder address is referenceOrganContract
    // Second stakeholder address is affectedOrganContract
    procedureLibrary.twoRegisteredOrgans public linkedOrgans;
    cyclicalVotingLibrary.RecurringElectionInfo public electionParameters;

    // Keeping track of current moderators, next moderators and which ballot is the next to be enforced
    address[] public currentModerators;
    address[] public nextModerators;
    uint public nextBallotToEnforce;

    // A dynamically-sized array of `Ballot` structs.
    //Ballot[] public ballots;
    cyclicalVotingLibrary.ElectionBallot public currentBallot;

    
    constructor(address payable _referenceOrganContract, address payable _affectedOrganContract, uint _ballotFrequency, uint _ballotDuration, uint _quorumSize, uint _reelectionMaximum, uint _voterToCandidateRatio, bytes32 _name) 
   
    public 
    {
        procedureInfo.initProcedure(2, _name, 2);
        linkedOrgans.initTwoRegisteredOrgans(_referenceOrganContract, _affectedOrganContract);
        electionParameters.initElectionParameters(_ballotFrequency, _ballotDuration, _quorumSize, _reelectionMaximum, 2*_ballotDuration, _voterToCandidateRatio);
    }

    /// Create a new ballot to choose one of `proposalNames`.
    function createBallot(bytes32 _ballotName) 
    public 
    {

        electionParameters.createRecurrentBallot(currentBallot, _ballotName);
        // Retrieving size of electorate
        Organ voterRegistryOrgan = Organ(linkedOrgans.firstOrganAddress);
        ( ,uint voterNumber) = voterRegistryOrgan.organInfos();

        currentBallot.electedOfficialSlotNumber = voterNumber/uint(electionParameters.voterToCandidateRatio);
        if ( currentBallot.electedOfficialSlotNumber == 0) 
        {
            currentBallot.electedOfficialSlotNumber = 1;
        }
        delete voterRegistryOrgan;
    }

    function presentCandidacy( bytes32 _ipfsHash, uint8 _hash_function, uint8 _size) 
    public 
    {
        // Check the candidate is a member of the reference organ
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);

        // Check that the ballot is still active
        electionParameters.presentCandidacyLib(currentBallot, _ipfsHash, _hash_function, _size);    
    }

    /// Vote for a candidate
    function vote(address[] memory _candidateAddresses) 
    public 
    {
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);
        electionParameters.voteManyToMany(currentBallot, _candidateAddresses);
    }

    // The vote is finished and we close it. This triggers the outcome of the vote.

    function endBallot() 
    public 
    {
        electionParameters.countManyToMany(currentBallot, nextModerators, linkedOrgans.firstOrganAddress);
    }
    
    function enforceBallot() 
    public 
    {
        // Checking the ballot is indeed the next one to be enforced
        require(currentBallot.ballotNumber >= nextBallotToEnforce);

        electionParameters.enforceManyToMany(currentBallot, nextModerators, currentModerators, linkedOrgans.secondOrganAddress);

        nextBallotToEnforce = currentBallot.ballotNumber + 1;

        delete currentBallot;
        currentBallot.ballotNumber = nextBallotToEnforce;
        // Removing data of nextModerators
        delete nextModerators;
    }

    //////////////////////// Functions to communicate with other contracts
    function getCandidateList() 
    public 
    view 
    returns (address[] memory _candidateList)
    {
        return currentBallot.candidateList;
    }
    
    function nextElectionICanVoteIn() 
    public 
    view 
    returns (uint lastElectionIParticipatedIn)
    {
        return electionParameters.nextElectionUserCanVoteIn[msg.sender];
    }

    function getCandidacyInfo(address _candidateAddress) 
    public 
    view
    returns (bytes32 _ipfsHash, uint8 _hash_function, uint8 _size)
    {
        return (electionParameters.candidacies[_candidateAddress].ipfsHash, electionParameters.candidacies[_candidateAddress].hash_function , electionParameters.candidacies[_candidateAddress].size);
    }


}
