pragma solidity ^0.4.24;

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
contract ex3 is exerciceTemplate {

	constructor(address _studentsOrganAddres, address _teachersOrganAddress, address _pointsManagerContractAddress) 
  exerciceTemplate(_studentsOrganAddres, _teachersOrganAddress, _pointsManagerContractAddress) 
  public
  {}
  
  function claimPoints(uint _studentUint) 
  public 
  canWorkOnExercice 
  {

  	require(_studentUint == 180618);

  	// Validating exercice
    validateExercice(msg.sender);
    creditStudent(200, msg.sender);

  }

}
