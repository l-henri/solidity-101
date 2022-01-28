pragma solidity ^0.6.0;


import "../exerciceTemplate.sol";

/*
Exercice 11: Finding a hidden exercice
In this exercice, you need to:
- Read the code of TDERC20
- Explore the ERC20 transactions history of the token's TD to figure out which exercises are able to credit points
- Find ex12 address
- Claim points
*/

/*

*/
contract ex12 is exerciceTemplate {

  uint public aValueToInput;

  constructor(ERC20TD _TDERC20) 
  public 
  exerciceTemplate(_TDERC20)
  {
    aValueToInput == 0;
  }

  function askForPoints(uint _valueToInput, uint _newValue) 
  public  
  {
    require(_valueToInput == aValueToInput);
    aValueToInput = _newValue;

    // Validating exercice
    validateExercice(msg.sender);
    creditStudent(2, msg.sender);

  }


}
