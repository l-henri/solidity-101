pragma solidity >=0.4.22 <0.6.0;

// Standard contract for promulgation of a norm

import "../standardProcedure.sol";
import "../Organ.sol";
import "../libraries/propositionVotingLibrary.sol";

contract voteOnExpenseProcedure is Procedure{
    // 1: Cyclical many to one election (Presidential Election)
    // 2: Cyclical many to many election (Moderators Election)
    // 3: Simple norm nomination 
    // 4: Simple admins and master nomination
    // 5: Vote on Norms 
    // 6: Vote on masters and admins 
    // 7: Cooptation
    // 8: Vote on an expense

    using procedureLibrary for procedureLibrary.fourRegisteredOrgans;
    using propositionVotingLibrary for propositionVotingLibrary.Proposition;
    using propositionVotingLibrary for propositionVotingLibrary.VotingProcessInfo;

    // First stakeholder address is votersOrganContract
    // Second stakeholder address is membersWithVetoOrganContract
    // Third stakeholder address is finalPromulgatorsOrganContract
    // Fourth stakeholder address is affectedOrganContract
    procedureLibrary.fourRegisteredOrgans public linkedOrgans;
    propositionVotingLibrary.VotingProcessInfo public votingProcedureInfo;

    constructor(address payable _affectedOrganContract, address payable _votersOrganContract, address payable _membersWithVetoOrganContract, address payable _finalPromulgatorsOrganContract, uint _quorumSize, uint _votingPeriodDuration, uint _promulgationPeriodDuration, uint _majoritySize, bytes32 _name) 
    public 
    {
        procedureInfo.initProcedure(8, _name, 4);
        linkedOrgans.initFourRegisteredOrgans(_votersOrganContract, _membersWithVetoOrganContract, _finalPromulgatorsOrganContract, _affectedOrganContract);
        votingProcedureInfo.initElectionParameters(_quorumSize, _votingPeriodDuration, _promulgationPeriodDuration, _majoritySize);
    }

    /// Create a new ballot to choose one of `proposalNames`.
    function createProposition(address payable _payoutAddress, uint _amount, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size) 
    public 
    returns (uint propositionNumber)
    {

        // Check the proposition creator is able to make a proposition
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);
        uint payoutAmount = _amount;
        // The proposed payout amount is stored in the propositionType field
        return votingProcedureInfo.createPropositionLib(linkedOrgans.fourthOrganAddress, _payoutAddress, address(0), _ipfsHash, _hash_function, _size, false, false, false, false, payoutAmount);
    }

    /// Vote for a proposition
    function vote(uint _propositionNumber, bool _acceptProposition) 
    public 
    {
        // Check the voter is able to vote on a proposition
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);
        votingProcedureInfo.voteLib(votingProcedureInfo.propositions[_propositionNumber], _acceptProposition);
    }

        /// Vote for a candidate
    function veto(uint _propositionNumber) 
    public 
    {
        // Check the voter is able to veto the proposition
        procedureLibrary.isAllowed(linkedOrgans.secondOrganAddress);
        
        votingProcedureInfo.propositions[_propositionNumber].vetoLib();
    }

    // The vote is finished and we close it. This triggers the outcome of the vote.

    function endPropositionVote(uint _propositionNumber) public returns (bool hasBeenAccepted) 
    {
        return votingProcedureInfo.endPropositionVoteLib(votingProcedureInfo.propositions[_propositionNumber], linkedOrgans.firstOrganAddress);
    }

    function promulgateProposition(uint _propositionNumber, bool _promulgate) public
    {
        // If promulgation is happening before endOfVote + promulgationPeriodDuration, check caller is an official promulgator
        if (now < votingProcedureInfo.propositions[_propositionNumber].votingPeriodEndDate + votingProcedureInfo.promulgationPeriodDuration)
        {        
            // Check the voter is able to promulgate the proposition
            procedureLibrary.isAllowed(linkedOrgans.thirdOrganAddress);
        }
        else 
        { 
            // If Promulgator did not promulgate, the only option is validating
            require(_promulgate);
        }

        votingProcedureInfo.propositions[_propositionNumber].processPayoutPropositionLib(_promulgate);
    }

    function haveIVoted(uint _propositionNumber) 
    public 
    view 
    returns (bool IHaveVoted)
    {
        return propositionVotingLibrary.getBoolean(votingProcedureInfo.userParticipation[msg.sender], _propositionNumber);
    }

    function getPropositionDocumentation(uint _propositionNumber) 
    public
    view
    returns (bytes32 ipfsHash, uint8 hash_function, uint8 size, uint propositionType)
    {
        return (votingProcedureInfo.propositions[_propositionNumber].ipfsHash, votingProcedureInfo.propositions[_propositionNumber].hash_function, votingProcedureInfo.propositions[_propositionNumber].size, votingProcedureInfo.propositions[_propositionNumber].propositionType);
    }

    function getPropositionStatus(uint _propositionNumber) 
    public
    view
    returns ( bool wasVetoed, bool wasCounted, bool wasAccepted, bool wasEnded, uint votingPeriodEndDate)
    {
        return (votingProcedureInfo.propositions[_propositionNumber].wasVetoed, votingProcedureInfo.propositions[_propositionNumber].wasCounted, votingProcedureInfo.propositions[_propositionNumber].wasAccepted, votingProcedureInfo.propositions[_propositionNumber].wasEnded, votingProcedureInfo.propositions[_propositionNumber].votingPeriodEndDate);
    }

    function getPropositionStatistics(uint _propositionNumber) 
    public
    view
    returns (uint voteFor, uint totalVoteCount)
    {
        require(votingProcedureInfo.propositions[_propositionNumber].votingPeriodEndDate < now);
        return (votingProcedureInfo.propositions[_propositionNumber].voteFor, votingProcedureInfo.propositions[_propositionNumber].totalVoteCount);
    }

    function getPropositionAddresses(uint _propositionNumber) 
    public
    view
    returns (address targetOrgan, address contractToAdd, address contractToRemove)
    {
        return (votingProcedureInfo.propositions[_propositionNumber].targetOrgan, votingProcedureInfo.propositions[_propositionNumber].contractToAdd, votingProcedureInfo.propositions[_propositionNumber].contractToRemove);
    }

    function getPropositionPermissions(uint _propositionNumber) 
    public
    view
    returns (bool canAdd, bool canDelete, bool canSpend, bool canDeposit)
    {
        return (votingProcedureInfo.propositions[_propositionNumber].canAdd, votingProcedureInfo.propositions[_propositionNumber].canDelete, votingProcedureInfo.propositions[_propositionNumber].canSpend, votingProcedureInfo.propositions[_propositionNumber].canDeposit);
    }

}

