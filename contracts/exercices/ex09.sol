pragma solidity ^0.6.0;


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


contract ex09 is exerciceTemplate { 

      event aLazyStudent(address _lazyStudent); 

  constructor(ERC20TD _TDERC20) 
  public 
  exerciceTemplate(_TDERC20)
  {
  }

// Find the code elsewhere

  function collectYourPoints(uint _aValueToInput)   
  public         
  { 
    require(_aValueToInput == 982738);  
    emit aLazyStudent(msg.sender);  

    // Validating exercice WITHOUT crediting points. Be careful, calling this function will NOT credit points to you!   
    validateExercice(msg.sender);   

  } 

  function collectYourPointsAgain(uint _aValueToInput)  
  public         
  { 
    require(_aValueToInput == 972738);  

    // Validating exercice, getting points  
    validateExercice(msg.sender);   
    creditStudent(2, msg.sender); 

  }
}