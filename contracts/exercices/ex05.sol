pragma solidity ^0.6.0;

import "../exerciceTemplate.sol";

/*
Exercice 5: Asking another student for help 
In this exercice, you need to:
- Use this contract's functions in order to declare one of your colleague address as your helper
- Ask this colleague to send a transaction to the contract
- Your points are credited by the contract
*/

/*
What you need to know to complete this exercice
A) What was included in the previous exercices
B) "Solidity mappings are a type that has some similarities to hash tables. Solidity mappings are used to structure value types for smart contracts." https://www.bitdegree.org/learn/solidity-mappings/
https://solidity.readthedocs.io/en/develop/types.html?highlight=mapping

*/
contract ex05 is exerciceTemplate {

	mapping(address => address) public helpersRegister;

  constructor(ERC20TD _TDERC20) 
  public 
  exerciceTemplate(_TDERC20)
  {
  }
  
  function declareHelper(address _helperAddress) 
  public  
  {
    require(_helperAddress != msg.sender);
  	helpersRegister[msg.sender] = _helperAddress;
  }
  
  function helpColleague(address _helpedColleague) 
  public  
  {
    require(hasCompletedExercice[_helpedColleague] != true);
    require(helpersRegister[_helpedColleague] == msg.sender);

  	// Validating exercice
    creditStudent(2, _helpedColleague);
    validateExercice(_helpedColleague);

  }

}
