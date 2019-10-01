# Vote on Admins and masters 
---
## Introduction
This contract is used to add/remove admins and masters in various organs, by allowing a group of participant to vote on the decision.

This is a [procedure](02_00_standardProcedure.md) of the [Kelsen](00_Kelsen.md) framework.

There are three roles in this procedure:
* Voters (Organ address stored in votersOrganContract)
* Vetoers (Organ address stored in membersWithVetoOrganContract)
* Promulgators (Organ address stored in finalPromulgatorsOrganContract)

These organs and the various time delays of the votes (votingPeriodDuration and promulgationPeriodDuration) are set when deploying the procedure initially.

This procedure can also be used to add norms in various organs, but it is not recommended to use it to do so.

## Step 1: Creating a proposition
Voters are able to promose the addition/removal/replacement of an admin in an organ, using function createProposition(). This function takes 12 parameters in input:
* Target Organ: The address of the organ to be modified
* PropositionType: The type of element we whish to add: 0 for masters, 1 for admins, 2 for norms.
* ContractToAdd: The address of the new admin/master to add, or the new address of a admin/master  to replace
* ContractToRemove: The address of the admin/master to remove, or the former address of a admin/master to replace
* -> By letting field contractToAdd or contractToRemove empty, it is possible to remove/add an admin/master. Filling both is a proposition to replace an admin/master.
* ipfsHash, hash_function, and size: Used to store a reference to a file, possibly on IPFS. These will be checkable during the vote process, in order to justify the decision to add/remove a admin/master. After the vote, they are NOT stored in the organ in case of admin/master. However, they are recorded in an event.
* name: Used to designate the admin/master in the organ
* canAdd: The ability to add norms/admins 
* canDelete: The ability to remove norms/admins
* canDeposit: The ability to deposit funds in the organ (used only for admins)
* canSpend: The ability to spend funds from the organ (used only for admins)

## Step 2: Getting proposition information

* A list of propositions open for vote can be found in propositionsWaitingEndOfVote[]
* Details of the permissions proposed in a proposition can be gathered with getPropositionDetails(). 
* Details of the proposition (Hash of documentation) can be retrieved with getPropositionDocumentation()
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
* 2. Deploy contract "voteOnAdminsAndMastersProcedure" (P1) with relevant addresses
* 3. Set P1 as a master of O4, using addMaster() method on O4. Set canAdd and canDelete to TRUE.
* 4. Add addresses in O1, O2, O3. 

You can now create propositions and vote on them

* 1. Create propositions with an address registered in O1
* 2. Vote on it with addresses in O1
* 3. Close the vote and enforce it with O3
* 4. Repeat, but veto the proposition with O2






