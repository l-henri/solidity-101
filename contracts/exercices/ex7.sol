pragma solidity ^0.4.24;


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
contract ex7 is exerciceTemplate {

	mapping(address => uint) private privateValues;
  uint[20] private randomValuesStore;
  uint public nextValueStoreRank;

  event showPrivateVariableInEvent(uint myVariable);

  constructor(address _studentsOrganAddres, address _teachersOrganAddress, address _pointsManagerContractAddress) 
  exerciceTemplate(_studentsOrganAddres, _teachersOrganAddress, _pointsManagerContractAddress) 
  public
  {}
  
  function setRandomValueStore(uint[20] _randomValuesStore) 
  public 
  onlyTeacher
  {
   randomValuesStore = _randomValuesStore;
   nextValueStoreRank = 0;
  }

  function startExercice() 
  public 
  canWorkOnExercice 
  {
    privateValues[msg.sender] = randomValuesStore[nextValueStoreRank];
    nextValueStoreRank += 1;
    if (nextValueStoreRank > randomValuesStore.length)
    {
     nextValueStoreRank = 0; 
    }
  }
  
  function fireEvent() 
  public 
  canWorkOnExercice 
  {
    emit showPrivateVariableInEvent(privateValues[msg.sender]+32);
  }

  function showYouKnowPrivateValue(uint _privateValue) 
  public 
  canWorkOnExercice 
  {
    require(privateValues[msg.sender] == _privateValue);

    // Validating exercice
    validateExercice(msg.sender);
    creditStudent(200, msg.sender);

  }

}
