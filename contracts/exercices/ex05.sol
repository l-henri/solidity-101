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
B) For a contract to work with another contract, a simple path is:
- In the .sol file, mporting the target contract's library 
- In your contract function, declare an instance of the target contract, at the address of the target contract
- Here, the students list is hosted in a contract whose address is stored in studentsOrgan
- You can then use the declared instance of the target contract with any allowed functions included into it
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
    validateExercice(_helpedColleague);
    creditStudent(2, _helpedColleague);

  }

}
