// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../exerciceTemplate.sol";

/*
Exercice 1: Creating an Ethereum Public address
In this exercice, you need to:
- Create an Ethereum public address
- Call function ping()
- Your points are credited
*/
/*
What you need to know to complete this exercice

A) Create a wallet using Metamask (http://metamask.io)

*/
contract ex01 is exerciceTemplate {

	constructor(ERC20TD _TDERC20) 
  exerciceTemplate(_TDERC20)
  {
  }
  
  function ping() 
  public  
  {
    // Validating exercice
    creditStudent(2, msg.sender);
    validateExercice(msg.sender);
  }

}
