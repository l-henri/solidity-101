# Cyclical many to many Election
---
## Introduction
This contract is used to organize the election of various leaders among a group of participants.

The group of participant is stored in the organ contract at address 'referenceOrganContract'. The moderators address is stored in an organ contract at address "affectedOrganContract".

The contract allows the organization of an election at frequency "ballotFrequency". Every time an election is organized, the date for the next election is defined.

This is a [procedure](02_00_standardProcedure.md) of the [Kelsen](00_Kelsen.md) framework.

## Instructions
The election is organized with function "CreateBallot". Each election can have a specific name. This will initialize a timer for two steps:
  * 1. The candidacy period. 
  * 2. The voting period. 

The total number of elections can be retrieved with getBallotNumber().

The details of a ballot can be retrieved with getSingleBallotInfo().

The details of the results and state of a ballot can be seen with getBallotResult()


## Candidacy period
* During this period, candidates can present their candidacy with function presentCandidacy(). 
* Their candidacy is authentified by the address they use. They need to be a member of the organisation to be a candidate.
* Voters can retrieve a list of candidate with function getCandidateList()
* The number of moderators that will be elected is electedOfficialSlotNumber =  totalVoterNumber / voterToCandidateRatio. voterToCandidateRatio is set when deploying the procedure

## Voting period
* Each member of the organisation can vote once and only once using vote(). 
* They have to specify the election number, as well as the addresses of the candidates they wish to vote for. 
* Voting for an address that is not in the candidate list is considered a neutral vote. It is accounted for in totalVoteCount and goes toward reaching quorumSize.
* The voters can vote for at most electedOfficialSlotNumber candidates. Trying to vote for more will reject their vote
* The list of candidates the voter wants to vote for needs to be ordered. For a list of N candidates in array candidateAddresses[], candidate 0 will get N vote, candidate 1 will get N - 1 vote, etc and candidate N will get 1 vote

## Vote counting
Once the voting period is ended, anyone can call function endBallot() to count votes and check the results. This will simply count the votes, a winner list will be designed and no action will be taken.

## Vote enforcing
Once the vote has been counted, it can be enforced. Anyone can call function enforceBallot(). This function will remove the former moderators from the structure, and will add the new moderators to the organ.

# Testing
To test this procedure, the following shall be done
* 1. Deploy two organs (O1 and O2). O1 will be the voter registry, O2 will be the moderators registry
* 2. Deploy contract "deployCyclicalManyToManyElectionProcedure" (P1). Before deploying: 
  * set O1 for "referenceOrganContract" and O2 for "affectedOrganContract"
  * Define the lengths you wish each step to last. candidacyDuration is the time to present your candidacy. ballotDuration is the time to vote. ballotFrequency is the length of the mandate. At all time, it is required that ballotDuration + candidacyDuration > ballotFrequency
* 3. Set P1 as an admin of O2, using addAdmin() method on P2. Set canAdd and canDelete to TRUE.
* 4. Add voters (addresses) in O1. 

You can now create a vote, and elect moderators.

* 1. On P1, call createBallot(). The argument can be left blank, or can be a string such as "First election"
* 2. Candidacy period has now started. Each address listed as a NORM in O1 can declare its candidacy. They can only declare once per ballot. 
* 3. After candidacyDuration, it is possible to vote(). Only once per address listed as a NORM in O1
* 4. After ballotDuration, it is possible to close the vote. Anyone can call endBallot(). The ballot results can be seen using getBallotResult() with the ballot number.
* 5. Once the vote has been ended, it can be enforced. This is done by anyone with enforceBallot(). 
* 6. You can now check that the winning candidates are listed as norms in O2






