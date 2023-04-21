// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../exerciceTemplate.sol";

/*
Exercice 2: Sending ETH to a public address
In this exercice, you need to:
- Send ETH to a public address (this contract's)
- Your points are credited by the contract
*/
/*
What you need to know to complete this exercice

A) What was included in the previous exercices
B) The function () is designed to receive transactions that include nothing but funds. If not specified, the contract can not receive this kind of transactions.
https://solidity.readthedocs.io/en/v0.4.25/contracts.html#fallback-function
C) The require() function is used to specify conditions that must be met for the contract to execute.
https://solidity.readthedocs.io/en/develop/control-structures.html?highlight=require(
D) The 'msg' object holds information regarding the account sending the transaction:
- msg.sender is the public address of the sender
- msg.value is the ETH value sent with this transaction 
https://solidity.readthedocs.io/en/develop/miscellaneous.html#index-4
*/
contract ex02 is exerciceTemplate {

	constructor(ERC20TD _TDERC20) 
  exerciceTemplate(_TDERC20)
  {
  }
  
  fallback () 
  external 
  payable  
  {

  	require(msg.value != 0);

  	// Validating exercice
    creditStudent(2, msg.sender);
    validateExercice(msg.sender);

  }

  receive () external payable 
  {
    require(msg.value != 0);

    // Validating exercice
    creditStudent(2, msg.sender);
    validateExercice(msg.sender);
  }


}
