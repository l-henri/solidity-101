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
What you need to know to complete this exercice
A) What was included in the previous exercices
B) Documentation of the Kelsen framework on https://github.com/97network/Kelsen/blob/master/docs/01_standardOrgan.md

*/
contract ex11b is exerciceTemplate {

  uint public secretValue;

  constructor(ERC20TD _TDERC20) 
  public 
  exerciceTemplate(_TDERC20)
  {
  }
  
  function setSecretValue(uint _newSecretValue)
  public
  onlyTeachers
  {
  	secretValue = _newSecretValue;
  }




}
