pragma solidity ^0.4.24;

import "../exerciceTemplate.sol";

/*
Exercice 4: Using contract functions to manipulate contract variables
In this exercice, you need to:
- Use this contract's functions in order to manipulate an internal counter unique to your address
- Once this counter reaches a certain value, call a specific function
- Your points are credited by the contract
*/

/*
What you need to know to complete this exercice
A) What was included in the previous exercices
B) "Solidity mappings are a type that has some similarities to hash tables. Solidity mappings are used to structure value types for smart contracts." https://www.bitdegree.org/learn/solidity-mappings/
https://solidity.readthedocs.io/en/develop/types.html?highlight=mapping
C)  x += y is used to add y to x. Similarly, x -= y is used to deduct y from x
D) Attributing a non 0 value to a uint in a smart contract will result in unpredictable behavior. As such, it is essential to make sure this never happens
*/
contract ex4 is exerciceTemplate {

	mapping(address => uint) public studentsCounter;
	mapping(address => bool) public exerciceWasStarted;

  constructor(address _studentsOrganAddres, address _teachersOrganAddress, address _pointsManagerContractAddress) 
  exerciceTemplate(_studentsOrganAddres, _teachersOrganAddress, _pointsManagerContractAddress) 
  public
  {}
  
  function initCounter() 
  public 
  canWorkOnExercice 
  {
  	studentsCounter[msg.sender] = 0;
  	exerciceWasStarted[msg.sender] = true;
  }
  
  function incrementCounter() 
  public 
  canWorkOnExercice 
  {
  	require(exerciceWasStarted[msg.sender] == true);
  	studentsCounter[msg.sender] += 2;
  }
 
  function decrementCounter() 
  public 
  canWorkOnExercice 
  {
  	require(exerciceWasStarted[msg.sender] == true);
  	require(studentsCounter[msg.sender] > 1);
  	studentsCounter[msg.sender] -= 1;
  }

  function validateCounter() 
  public 
  canWorkOnExercice 
  {

  	require(studentsCounter[msg.sender] == 7);

  	// Validating exercice
    validateExercice(msg.sender);
    creditStudent(200, msg.sender);

  }

}
