# Standard organ
---
## Introduction
This contract is used to create an organ.

There are three roles in this contract:
* Norms
* Admins
* Masters

Organs are a part of the [Kelsen](00_Kelsen.md) framework

## 1. Norms

An organ is a repository of references (Norms). Maintaining this norms registry is the purpose of this contract. 

A norm has two attributes:
* An address
* A file hash

Both are not required, but at least one is. Addresses can not be listed twice.

* A new norm can be created, removed of modified with addNorm(), remNorm() and replaceNorm(). Restricted to admins.
* It is possible to check if an address is in Norms with isNorm()
* You can check the norm number if you have its address, using getAddressPositionInNorm()
* A norm is readable using getSingleNorm() with the norm number


## 2. Admins 
An admin is an address that can add, delete or replace a norm. It can be a contract or a person.
* Retrieve the admin list using adminList[]
* Check an admin privileges using isAdmin() which returns the permission to add, and to delete
* An admin is added, deleted or replaced using addAdmin(), remAdmin(), and replaceAdmin(). Restricted to masters.
Admins can also deposit or spend funds stored in the organ, with specific permissions (canDeposit and canSpend). Depositing funds is made by simply sending funds to the organ, while paying is made with the transfer() function.

## 3. Masters
A master is an address that can add, delete or replace an admin. It can be a contract or a person.
* Retrieve the masters list using masterList[]
* Check a master privileges using isMaster() which returns the permission to add, and to delete
* A master is added, deleted or replaced using addMaster(), remMaster(), and replaceMaster(). Restricted to masters.


# Testing
You can test an organ as follow:
* Use deployOrgan to create an organ where you are a master, with account A1
* Add an admin (A2) using A1
* Add a norm (A3) using A2
* Remove A3 from norms 
* Remove A2 from admins
* Remove A1 from masters
