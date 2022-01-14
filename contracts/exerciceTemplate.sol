pragma solidity ^0.6.0;

import "./ERC20TD.sol";

/*
Common behavior in exercices

This contract describes functions that are common to most exercices. They help
- Authentify students and teacher
- Credit students
*/

contract exerciceTemplate {

  ERC20TD TDERC20;

  mapping(address => bool) public hasCompletedExercice;

  event constructedCorrectly(address erc20Address);
  constructor(ERC20TD _TDERC20) 
  public 
  {
    TDERC20 = _TDERC20;
    emit constructedCorrectly(address(TDERC20));
  }

  function creditStudent(uint _points, address _studentAddress) internal {
    if (!hasCompletedExercice[_studentAddress])
    {
      TDERC20.distributeTokens(msg.sender, _points);
    }
  }

  function validateExercice(address _studentAddress) internal {
    hasCompletedExercice[_studentAddress] = true;
  }



  modifier onlyTeachers() 
  {

      require(TDERC20.teachers(msg.sender));
      _;
  }
}
