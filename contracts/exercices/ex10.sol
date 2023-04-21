// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../exerciceTemplate.sol";

/*
Exercice 10: Analyzing past transactions
In this exercice, you need to:
- Use Etherscan to visualize this contract's transaction history
- Analyze events
- Use a function 
- Your points are credited by the contract
*/

/*
What you need to know to complete this exercice
A) What was included in the previous exercices

*/
contract ex10 is exerciceTemplate {


	mapping(address => uint) private privateValues;
  mapping(address => bool) public exerciceWasStarted;
  uint[20] private randomValuesStore;
  uint public nextValueStoreRank;

  event showPrivateVariableInEvent(uint i, uint myVariable);
  event showUserRank(uint i);

  constructor(ERC20TD _TDERC20)  
  exerciceTemplate(_TDERC20)
  {
  }
  
  function setRandomValueStore(uint[20] memory _randomValuesStore) 
  public 
  onlyTeachers
  {
   randomValuesStore = _randomValuesStore;
   nextValueStoreRank = 0;
   for (uint i = 0; i < randomValuesStore.length; i++)
   {
   	emit showPrivateVariableInEvent(i, randomValuesStore[i]+i);
   }
  }

  function assignRank() 
  public  
  {
    privateValues[msg.sender] = randomValuesStore[nextValueStoreRank];
    emit showUserRank(nextValueStoreRank);
    nextValueStoreRank += 1;
    if (nextValueStoreRank >= randomValuesStore.length)
    {
     nextValueStoreRank = 0; 
    }
    exerciceWasStarted[msg.sender] = true;
  }

  function showYouKnowPrivateValue(uint _privateValue) 
  public 
  {
    require(privateValues[msg.sender] == _privateValue);
    require(exerciceWasStarted[msg.sender] == true);
    
    // Validating exercice
    creditStudent(2, msg.sender);
    validateExercice(msg.sender);
  }


}
