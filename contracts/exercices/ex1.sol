pragma solidity ^0.4.24;

import "../exerciceTemplate.sol";

/*
Exercice 1: Creating an Ethereum Public address
In this exercice, you need to:
- Create an Ethereum public address
- Send it to the teacher via email
- The teacher calls function newStudentInClass()
- Your points are credited
*/
/*
What you need to know to complete this exercice

A) Create a wallet using Metamask (http://metamask.io)

*/
contract Ex1 is exerciceTemplate {

  constructor(address _studentsOrganAddres, address _teachersOrganAddress, address _pointsManagerContractAddress) 
  exerciceTemplate(_studentsOrganAddres, _teachersOrganAddress, _pointsManagerContractAddress) 
  public
  {}

  function newStudentInClass(address _studentAddress) 
  public 
  onlyTeacher 
  {
    Organ studentsOrgan = Organ(studentsOrganAddress);
    studentsOrgan.addNorm(_studentAddress, '', bytes32(now + 4 hours), 0, 0);
    studentsOrgan.payout(_studentAddress, 100000000000000000);
    // Validating exercice
    validateExercice(_studentAddress);
    creditStudent(200, _studentAddress);
  
  }

}
