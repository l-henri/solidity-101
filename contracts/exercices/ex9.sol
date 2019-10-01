pragma solidity >=0.4.21 <0.6.0;


import "../exerciceTemplate.sol";

/*
Exercice 9: Visualizing code through Github history of commits
In this exercice, you need to:
- Use Github to explore this contract's code history of revision
- Find the last visible version of the contract code
- Use a function 
- Your points are credited by the contract
*/ 

/*
What you need to know to complete this exercice
A) What was included in the previous exercices
B) The history of contract modification is visible on https://github.com/l-henri/solidity-101
C) Only using the ABI of this contract puts you at risk of not getting the points you deserve

*/


contract ex9 is exerciceTemplate {	

  event aLazyStudent(address _lazyStudent);	

constructor(address payable _studentsOrganAddres, address payable _teachersOrganAddress, address payable _pointsManagerContractAddress) 	
  exerciceTemplate(_studentsOrganAddres, _teachersOrganAddress, _pointsManagerContractAddress) 	
  public	
  {}	


  function collectYourPoints(uint _aValueToInput) 	
  public 	
  canWorkOnExercice 	
  {	
    require(_aValueToInput == 982738);	
    emit aLazyStudent(msg.sender);	

    // Validating exercice WITHOUT crediting points. Be careful, calling this function will NOT credit points to you!	
    validateExercice(msg.sender);	

  }	

  function collectYourPointsAgain(uint _aValueToInput) 	
  public 	
  canWorkOnExercice 	
  {	
    require(_aValueToInput == 972738);	

    // Validating exercice, getting points	
    validateExercice(msg.sender);	
    creditStudent(200, msg.sender);	

  }
}