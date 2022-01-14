pragma solidity ^0.6.0;

import "../exerciceTemplate.sol";

/*
Exercice 1: Creating an Ethereum Public address
In this exercice, you need to:
- Create an Ethereum public address
- Send it to the teacher via email
- The teacher calls function newStudentInClass()
- Your points are credited
*/
/*
What you need to know to complete this exercice

A) Create a wallet using Metamask (http://metamask.io)

*/
contract ex01 is exerciceTemplate {

	constructor(ERC20TD _TDERC20) 
  public 
  exerciceTemplate(_TDERC20)
  {
  }
  
  function ping(address payable _studentAddress) 
  public  
  {
    // Validating exercice
    validateExercice(_studentAddress);
    creditStudent(2, _studentAddress);
  }

}
