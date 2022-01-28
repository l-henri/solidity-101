pragma solidity ^0.6.0;

import "../exerciceTemplate.sol";

/*
Exercice 3: Using a simple public contract function
In this exercice, you need to:
- Use this contract's claimPoints() function
- Understand the require() keyword and send the correct value to pass the requirement
- Your points are credited by the contract
*/
 
/*
What you need to know to complete this exercice
A) What was included in the previous exercices
B) Understanding requires https://docs.soliditylang.org/en/v0.6.0/control-structures.html#id4
*/
contract ex03 is exerciceTemplate {

  constructor(ERC20TD _TDERC20) 
  public 
  exerciceTemplate(_TDERC20)
  {
  }
  
  function claimPoints(uint _studentUint) 
  public 
  {

  	require(_studentUint == 180618, "Value is incorrect");

  	// Validating exercice
    creditStudent(2, msg.sender);
    validateExercice(msg.sender);

  }

}
