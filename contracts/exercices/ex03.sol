pragma solidity ^0.6.0;

import "../exerciceTemplate.sol";

/*
Exercice 3: Using a simple public contract function
In this exercice, you need to:
- Use this contract's claimPoints() function
- Your points are credited by the contract
*/
 
/*
What you need to know to complete this exercice
A) What was included in the previous exercices
B) The contract ABI is included in the "build" folder at the root of the repo, in a JSON file

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

  	require(_studentUint == 180618);

  	// Validating exercice
    validateExercice(msg.sender);
    creditStudent(2, msg.sender);

  }

}
