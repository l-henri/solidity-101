pragma solidity ^0.6.0;


import "../exerciceTemplate.sol";
import "./Iex14Solution.sol";

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
contract ex14 is exerciceTemplate {


  constructor(ERC20TD _TDERC20) 
  public 
  exerciceTemplate(_TDERC20)
  {
  }

  function askForPoints(address mySolution) 
  public  
  {
    // Checking that solution has no token yet
    uint256 initialBalance = TDERC20.balanceOf(mySolution);
    require(initialBalance == 0, "Solution should start with 0 points");

    // Calling the solution so that it solves the workshop
    Iex14Solution callerSolution = Iex14Solution(mySolution);
    callerSolution.completeWorkshop();

    // Checking that at least 10 exercices where validated
    uint256 finalBalance = TDERC20.balanceOf(mySolution);
    uint256 decimals = TDERC20.decimals();
    require(finalBalance >= 10**decimals *24, "Solution should end with at least than 24 points");

    // Validating exercice
    creditStudent(2, msg.sender);
    validateExercice(msg.sender);

  }


}
