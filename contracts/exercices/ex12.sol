pragma solidity ^0.6.0;


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

*/
contract ex12 is exerciceTemplate {

  constructor(ERC20TD _TDERC20) 
  public 
  exerciceTemplate(_TDERC20)
  {
  }

  function askForPoints(uint _aValueToInput) 
  public  
  {
    require(_aValueToInput == 98272338);

    // Validating exercice
    validateExercice(msg.sender);
    creditStudent(2, msg.sender);

  }


}
