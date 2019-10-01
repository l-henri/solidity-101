# Norms cooptation
---
## Introduction
This contract is used to add/remove a norm in a specific organ, by allowing a group of participant to vote on the decision. Any participant can ask for its integration in the organ, by depositing a small fee during its inscription. After the vote, voters who voted with the winning side each get a share of the deposit of the candidate.

The affected organ address is stored in an organ contract at address "membersOrganContract". It is also the organ used to list voters.

The various time delays of the votes are defined when deploying the procedure, with variables votingPeriodDuration and promulgationPeriodDuration. The minimum deposit size is also fixed when deloying, in minimumDepositSize variable.

This is a [procedure](02_00_standardProcedure.md) of the [Kelsen](00_Kelsen.md) framework.

There are three roles in this procedure:
* Voters
* Vetoers
* Promulgators

This procedure is largely derived from the [Vote on norms](02_05_voteOnNormsProcedure.md) procedure.

## Step 1: Creating a proposition
Any outside member can ask to become a new member, using function createProposition(). This function takes 4 parameters in input:
* ipfsHash, hash_function, and size: Used to store a reference to a file, possibly on IPFS. These will be checkable during the vote process, and they will be stored in the organ after promulgation. 
* name: Used to designate the norm in the organ
Calling createProposition() needs also to be done with an ether amount superior to minimumDepositSize.

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

## Step 6: Withdrawing
Once the vote was counted and enforced, participant are able to withdraw their proceedings from the vote using withDrawPayout().

# Testing
To test this procedure, the following shall be done
* 1. Deploy 3 organs (O1, O2, 03). O1 will be the voter registry, O2 will be the vetoers registry, O3 will be the promulgator registry
* 2. Deploy contract "normsCooptationProcedure" (P1) with relevant addresses
* 3. Set P1 as an admin of O1, using addAdmin() method on O1. Set canAdd, canDelete, canDeposit and canSpend to TRUE.
* 4. Add addresses in O1, O2, O3. 

You can now create propositions and vote on them

* 1. Create propositions with any address you like
* 2. Vote on it with addresses in O1
* 3. Close the vote and enforce it with O3
* 4. Withdraw payouts with addresses in O1 that voted
* 5. Repeat, but veto the proposition with O2






