pragma solidity ^0.4.24;


import "../exerciceTemplate.sol";

/*
Exercice 9: Visualizing code online
In this exercice, you need to:
- Use Etherscan to visualize this contract's code
- Use a function 
- Your points are credited by the contract
*/

/*
What you need to know to complete this exercice
A) What was included in the previous exercices
B) Etherscan.io https://etherscan.io/ lets you visualize the source code of contracts whose creator disclosed it. 

*/
contract ex9 is exerciceTemplate {

	constructor(address _studentsOrganAddres, address _teachersOrganAddress, address _pointsManagerContractAddress) 
  exerciceTemplate(_studentsOrganAddres, _teachersOrganAddress, _pointsManagerContractAddress) 
  public
  {}


  function collectYourPoints(uint _aValueToInput) 
  public 
  canWorkOnExercice 
  {
    require(_aValueToInput == 982738);

    // Validating exercice WITHOUT crediting points. Be careful, calling this function will NOT credit points to you!
    validateExercice(msg.sender);

  }

  function collectYourPointsAgain(uint _aValueToInput) 
  public 
  canWorkOnExercice 
  {
    require(_aValueToInput == 982738);

    // Validating exercice, getting points
    validateExercice(msg.sender);
    creditStudent(200, msg.sender);

  }
}
