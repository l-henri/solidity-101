pragma solidity >=0.4.22 <0.6.0;

// Standard contract for a presidential election procedure

import "../standardProcedure.sol";
import "../Organ.sol";
import "../libraries/cyclicalVotingLibrary.sol";


contract cyclicalManyToOneElectionProcedure is Procedure
{
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

    // ############## Variable to set up when declaring the procedure
    // ####### Vote creation process

    // current President address
    address public currentPresident;

    // A dynamically-sized array of `Ballot` structs.
    cyclicalVotingLibrary.ElectionBallot public currentBallot;

    constructor(address payable _referenceOrganContract, address payable _affectedOrganContract, uint _ballotFrequency, uint _ballotDuration, uint _quorumSize, uint _reelectionMaximum, bytes32 _name) 
    public 
    {
        procedureInfo.initProcedure(1, _name, 2);
        linkedOrgans.initTwoRegisteredOrgans(_referenceOrganContract, _affectedOrganContract);
        electionParameters.initElectionParameters(_ballotFrequency, _ballotDuration, _quorumSize, _reelectionMaximum, 2*_ballotDuration, 0);
    }

    /// Create a new ballot to choose one of `proposalNames`.
    function createBallot(bytes32 _ballotName) 
    public 
    {
        electionParameters.createRecurrentBallot(currentBallot, _ballotName);
    }

    function presentCandidacy(bytes32 _ipfsHash, uint8 _hash_function, uint8 _size) 
    public 
    {

        // Check the candidate is a member of the reference organ
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);
        electionParameters.presentCandidacyLib(currentBallot, _ipfsHash, _hash_function, _size);
    }


    /// Vote for a candidate
    function vote(address payable _candidateAddress) 
    public 
    {
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);
        electionParameters.voteManyToOne(currentBallot, _candidateAddress);
    }

    // The vote is finished and we close it. This triggers the outcome of the vote.

    function endBallot() 
    public 
    returns (address electionWinner)
    {
       electionWinner = electionParameters.countManyToOne(currentBallot, linkedOrgans.firstOrganAddress);   

        if (electionWinner != address(0))
        {
            electionParameters.cumulatedMandates[electionWinner] += 1;

            if (electionWinner != currentPresident)
            {
                electionParameters.givePowerToNewPresident(currentBallot, electionWinner, currentPresident, linkedOrgans.secondOrganAddress);
            }

            delete electionParameters.candidacies[electionWinner];
        }
        
        uint nextBallotNumber = currentBallot.ballotNumber + 1;
        // Cleaning contract state from election
        delete currentBallot;
        currentBallot.ballotNumber = nextBallotNumber;

        return electionWinner;          
    }
        
    // ######### Functions to retrieve procedure infos

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

