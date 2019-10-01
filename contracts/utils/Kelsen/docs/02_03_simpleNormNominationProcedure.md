# Simple Norm Nomination
---
## Introduction
This procedure allows various contracts to add norms in an organ. It can be used to manage membership subscription: Various contracts can each have a register of active members, and the organisation wants to group members in a single organ - for voting purposes for example.

This procedure is made to be multi target. It can be used to manage various organs. 

Allowed nominators are stored in the organ authorizedNominatersOrgan. authorizedNominatersOrgan is defined when deploying the procedure with contract deploySimpleNormNominationProcedure.

This is a [procedure](02_00_standardProcedure.md) of the [Kelsen](00_Kelsen.md) framework.

## Adding a norm
Authorized nominators can call addNorm() with six parameters:
* targetOrgan, the organ to be modified
* normAdress , the address of the norm
* name , a string describing the norm
* ipfsHash, hash_function and size, which are used to stored documents on IPFS relative to the nomination decision

The norm is then stored in the organ with the reference to the documents related to its nomination.

## Editing a norm
Authorized nominators can call replaceNorm() with the same parameters as before. The only difference is that the norm to be modified is not designated by its address, but by a number. This means that before calling replaceNorm(), nominators need to use getAddressPositionInNorm() on the target organ in order to retrieve the norm number.

## Deleting a norm
Authorized nominators can call remNorm() with two parameters:
* targetOrgan, the organ to be modified
* normNumber , the number of the address she wishes to remove in the target organ.

The norm to be modified need to be designated by its number. This means that before calling remNorm(), nominators need to use getAddressPositionInNorm() on the target organ in order to retrieve the norm number.

# Testing

* Deploy an organ O1
* Declare addresses A1, A2, A3 as norms of O1
* Deploy simple norms nomination procedure (P1), with O1's adress as authorizedNominatersOrgan
* Deploy organ O2
* Set P1 as an admin of O2
* Use A1, A2 or A3 to add, remove or replace norms in O2, using P1

