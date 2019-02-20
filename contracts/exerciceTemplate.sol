pragma solidity ^0.4.24;

// Using Kelsen framework for authentification of stakeholders.
// More info on https://github.com/97network/Kelsen
// What you need to know for this session: https://github.com/97network/Kelsen/blob/master/docs/01_standardOrgan.md
import "./utils/Kelsen/standardOrgan.sol";
import "./pointsManager.sol";

/*
Common behavior in exercices

This contract describes functions that are common to most exercices. They help
- Authentify students and teacher
- Credit students
*/

contract exerciceTemplate {

	// Pointing at Kelsen organs listing stakeholders
  address public studentsOrganAddress;
  address public pointsManagerContractAddress;
  address public teachersOrganAddress;

  mapping(address => bool) public hasCompletedExercice;

  constructor(address _studentsOrganAddres, address _teachersOrganAddress, address _pointsManagerContractAddress) public
  {
    studentsOrganAddress = _studentsOrganAddres;
    teachersOrganAddress = _teachersOrganAddress;
    pointsManagerContractAddress = _pointsManagerContractAddress;
  }

  function creditStudent(uint _points, address _studentAddress) internal {
    pointsManager pointsManagerContract = pointsManager(pointsManagerContractAddress);
    pointsManagerContract.grantPoints(_points, _studentAddress);
  }

  function validateExercice(address _studentAddress) internal {
    hasCompletedExercice[_studentAddress] = true;
  }


  modifier canWorkOnExercice() {
    Organ studentsOrgan = Organ(studentsOrganAddress);
    uint studentPosition = studentsOrgan.getAddressPositionInNorm(msg.sender);
    require( studentPosition != 0);
    ( , , bytes32 deadLine , , ) = studentsOrgan.norms(studentPosition);
    require(uint(deadLine) > now);
    require(hasCompletedExercice[msg.sender] != true);
    _;
  }

  modifier onlyTeacher() {
    Organ teachersOrgan = Organ(teachersOrganAddress);
    // require(teachersOrgan.isNorm(msg.sender));
    require(teachersOrgan.getAddressPositionInNorm(msg.sender) != 0);
    _;
  }
}
