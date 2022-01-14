pragma solidity ^0.6.0;


import "../exerciceTemplate.sol";

/*
Exercice 7: Events
In this exercice, you need to:
- Use a function to trigger an event
- Use Etherscan to analyse this event
- Use a function to show you know the correct value of a private variable
- Your points are credited by the contract
*/

/*
What you need to know to complete this exercice
A) What was included in the previous exercices
B) Events are used to log data that is accessible from a full node, but not stored in the contracts variables.
https://solidity.readthedocs.io/en/develop/introduction-to-smart-contracts.html#index-2
C) Etherscan.io https://etherscan.io/ lets you visualize events that were fired during a given transaction

*/
contract ex07 is exerciceTemplate {

	mapping(address => uint) private privateValues;
  mapping(address => bool) public exerciceWasStarted;
  uint[20] private randomValuesStore;
  uint public nextValueStoreRank;

  event showPrivateVariableInEvent(uint myVariable);
  
  constructor(ERC20TD _TDERC20) 
  public 
  exerciceTemplate(_TDERC20)
  {
  }

  function setRandomValueStore(uint[20] memory _randomValuesStore) 
  public 
  onlyTeachers
  {
   randomValuesStore = _randomValuesStore;
   nextValueStoreRank = 0;
  }

  function startExercice() 
  public  
  {
    privateValues[msg.sender] = randomValuesStore[nextValueStoreRank];
    nextValueStoreRank += 1;
    if (nextValueStoreRank >= randomValuesStore.length)
    {
     nextValueStoreRank = 0; 
    }
    exerciceWasStarted[msg.sender] = true;
  }
  
  function fireEvent() 
  public  
  {
    emit showPrivateVariableInEvent(privateValues[msg.sender]+32);
  }

  function showYouKnowPrivateValue(uint _privateValue) 
  public  
  {
    require(privateValues[msg.sender] == _privateValue);
    require(exerciceWasStarted[msg.sender] == true);
    
    // Validating exercice
    validateExercice(msg.sender);
    creditStudent(2, msg.sender);

  }

}
