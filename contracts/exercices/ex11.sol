// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../exerciceTemplate.sol";
import "./ex11b.sol";
/*
Exercice 11: Understanding how contracts communicate with each other.
This contract (11) reads a value from another contract (11b).
In this exercice, you need to:
- Find out the address of contract 11b
- Understand which function of contract 11b contract 11 calls
- Use contract 11b to find out what is the value required
- Call contract 11 with the correct value, which will call contract 11b to check you have the correct value, and deliver your points.
*/

/*
What you need to know to complete this exercice
A) What was included in the previous exercices
B) https://medium.com/@blockchain101/calling-the-function-of-another-contract-in-solidity-f9edfa921f4c#targetText=When%20we%20write%20Smart%20Contracts,treating%20deployed%20contracts%20like%20libraries.

*/
contract ex11 is exerciceTemplate {

  address public ex11bAddress;

  constructor(ERC20TD _TDERC20, address _ex11bAddress) 
  exerciceTemplate(_TDERC20)
  {
    ex11bAddress = _ex11bAddress;
  }



  function askForPoints(uint _aValueToInput, uint _nextValueForSecret) 
  public 
  {
    // Instanciating the external contract
    ex11b ex11bInstance = ex11b(ex11bAddress);

    // Retrieving value from external contract
    uint retrievedSecretValue = ex11bInstance.secretValue();

    // Checking that our input value is the one stored in contract ex11b
    require(_aValueToInput == retrievedSecretValue);

    // Updating secret value with the new value you chose
    ex11bInstance.setSecretValue(_nextValueForSecret);

    // Validating exercice
    creditStudent(2, msg.sender);
    validateExercice(msg.sender);

  }


}
