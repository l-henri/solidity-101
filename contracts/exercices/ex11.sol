pragma solidity ^0.4.24;


import "../exerciceTemplate.sol";

/*
Exercice 11: Finding a hidden exercice
In this exercice, you need to:
- Read the documentation of another contract to understand its structure
- Extract contract ABI
- Use the ABI to extract the contract content and find the missing contract
- Call the contract function
- Your points are credited by the contract
*/

/*
What you need to know to complete this exercice
A) What was included in the previous exercices
B) Documentation of the Kelsen framework on https://github.com/97network/Kelsen/blob/master/docs/01_standardOrgan.md

*/
contract ex11 is exerciceTemplate {

  constructor(address _studentsOrganAddres, address _teachersOrganAddress, address _pointsManagerContractAddress) 
  exerciceTemplate(_studentsOrganAddres, _teachersOrganAddress, _pointsManagerContractAddress) 
  public
  {}


  function askForPoints(uint _aValueToInput) 
  public 
  canWorkOnExercice 
  {
    require(_aValueToInput == 98272338);

    // Validating exercice
    validateExercice(msg.sender);
    creditStudent(200, msg.sender);

  }


}
