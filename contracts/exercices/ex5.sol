pragma solidity >=0.4.21 <0.6.0;

// Using Kelsen framework for authentification of stakeholders.
// More info on https://github.com/97network/Kelsen
// What you need to know for this session: https://github.com/97network/Kelsen/blob/master/docs/01_standardOrgan.md
// This tool is NOT necessary to understand to complete this exercice

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
contract ex5 is exerciceTemplate {

	mapping(address => address) public helpersRegister;

  constructor(address payable _studentsOrganAddres, address payable _teachersOrganAddress, address payable _pointsManagerContractAddress) 
  exerciceTemplate(_studentsOrganAddres, _teachersOrganAddress, _pointsManagerContractAddress) 
  public
  {}
  
  function declareHelper(address _helperAddress) 
  public 
  canWorkOnExercice 
  {
    require(_helperAddress != msg.sender);
    Organ studentsOrgan = Organ(studentsOrganAddress);
    require(studentsOrgan.getAddressPositionInNorm(msg.sender) != 0);
  	helpersRegister[msg.sender] = _helperAddress;
  }
  
  function helpColleague(address _helpedColleague) 
  public  
  {
    require(hasCompletedExercice[_helpedColleague] != true);
    require(helpersRegister[_helpedColleague] == msg.sender);

  	// Validating exercice
    validateExercice(_helpedColleague);
    creditStudent(200, _helpedColleague);

  }

}
