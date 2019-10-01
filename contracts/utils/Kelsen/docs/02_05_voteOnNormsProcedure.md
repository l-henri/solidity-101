# Vote on norms 
---
## Introduction
This contract is used to add/remove a norm in a specific organ, by allowing a group of participant to vote on the decision.

The group of participant (voters) is stored in the organ contract at address 'votersOrganContract'. The affected organ address is stored in an organ contract at address "affectedOrganContract".

The various time delays of the votes are defined when deploying the procedure, with variables votingPeriodDuration and promulgationPeriodDuration.

This is a [procedure](02_00_standardProcedure.md) of the [Kelsen](00_Kelsen.md) framework.

There are three roles in this procedure:
* Voters
* Vetoers
* Promulgators

## Step 1: Creating a proposition
Voters are able to promose the promulgation of a norm in affectedOrganContract, using function createProposition(). This function takes 6 parameters in input:
* ContractToAdd: The address of the new norm to add, or the new address of a norm to replace
* ContractToRemove: The address of the norm to remove, or the former address of a norm to replace
* -> By letting field contractToAdd or contractToRemove empty, it is possible to remove/add a norm. Filling both is a proposition to replace a norm.
* ipfsHash, hash_function, and size: Used to store a reference to a file, possibly on IPFS. These will be checkable during the vote process, and they will be stored in the organ after promulgation. 
* name: Used to designate the norm in the organ

## Step 2: Getting proposition information

* A list of propositions open for vote can be found in propositionsWaitingEndOfVote[]
* Details of a proposition can be gathered with getPropositionDetails(). 
* Timing information for a proposition can be retrieved with getPropositionDates()
* The status of the proposition (open for vote, promulgation, closed, accepted) can be retrieved with getPropositionStatus()

## Step 3: Voting
* Voters can vote for or against a proposition with vote()
* Vetoers can decide to block the vote with function veto(). In that case, the vote will still proceed and be counted, but will not be enforced.

## Step 4: Counting the vote

* Once the voting period is over, the vote is counted with endPropositionVote().
* The election result can be retrieved with getVotedPropositionResults(). If the vote was accepted and not vetoed, hasBeenAccepted will be set a true.


## Step 5: Enforcing the vote if it was validated
* If the vote was negative (voters decided to NOT enact proposition), it is not possible to enforce the proposition
* After acceptation, the promulgators have a period of promulgationPeriodDuration seconds to enforce the vote using promulgateProposition(). They can decide to stop the proposition, too.
* If the promulgator does not act after promulgationPeriodDuration, anyone can enforce the vote


# Testing
To test this procedure, the following shall be done
* 1. Deploy 4 organs (O1, O2, 03, 04). O1 will be the voter registry, O2 will be the vetoers registry, O3 will be the promulgator registry, O4 will be the norm registry
* 2. Deploy contract "voteOnNormsProcedure" (P1) with relevant addresses
* 3. Set P1 as an admin of O4, using addAdmin() method on O4. Set canAdd and canDelete to TRUE.
* 4. Add addresses in O1, O2, O3. 

You can now create propositions and vote on them

* 1. Create propositions with an address registered in O1
* 2. Vote on it with addresses in O1
* 3. Close the vote and enforce it with O3
* 4. Repeat, but veto the proposition with O2






