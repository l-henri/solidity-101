# Simple admins and masters nomination
---
## Introduction
This procedure allows a group of admins registered in organ A to manage admins and masters of an organ B. 


Allowed nominators are stored in the organ authorizedReformersOrgan. authorizedReformersOrgan is defined when deploying the procedure with contract deploySimpleAdminsAndMasterNominationProcedure.


This procedure is made to be multi target. It can be used to manage various organs. 


This is a [procedure](02_00_standardProcedure.md) of the [Kelsen](00_Kelsen.md) framework.

## Managing Admins
Admins are managed with addAdmin(), replaceAdmin() and remAdmin(). Function names are self explanatory. Admins are designated with their addresses in function calls. Admin permissions are stored in booleans as followed:
* canAdd: The ability to add norms
* canDelete: The ability to remove norms
* canDeposit: The ability to deposit funds in the organ
* canSpend: The ability to spend funds from the organ

## Managing Masters
Masters are managed with addMaster(), replaceMaster() and remMaster(). Function names are self explanatory. Masters are designated with their addresses in function calls. Master permissions are stored in booleans as followed:
* canAdd: The ability to add admins
* canDelete: The ability to remove admins

# Testing

* Deploy an organ O1
* Declare addresses A1, A2, A3 as norms of O1
* Deploy simple admins and masters nomination procedure (P1), with O1's adress as authorizedReformersOrgan
* Deploy organ O2
* Set P1 as a master of O2
* Use A1, A2 or A3 to add, remove or replace masters/admins in O2, using P1

