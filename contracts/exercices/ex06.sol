pragma solidity ^0.6.0;


import "../exerciceTemplate.sol";

/*
Exercice 6: public/private variables
In this exercice, you need to:
- Use a function to get assigned a private variable
- Use a function to duplicate this variable in a public variables
- Use a function to show you know the correct value of the private variable
- Your points are credited by the contract
*/

/*
What you need to know to complete this exercice
A) What was included in the previous exercices
B) The differences between public and private variables https://solidity.readthedocs.io/en/develop/contracts.html#index-3
C) What a contract constructor is https://solidity.readthedocs.io/en/develop/contracts.html#index-17
D) When the contract is created, the teacher creates an array called randomValuesStore. 
When students start the exercice, they get assigned one of these values.
*/
contract ex06 is exerciceTemplate {

	mapping(address => uint) private privateValues;
  mapping(address => uint) public publicValues;
  mapping(address => bool) public exerciceWasStarted;

  uint[20] private randomValuesStore;
  uint public nextValueStoreRank;

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
  
  function duplicatePrivateValueInPublic() 
  public  
  {
    publicValues[msg.sender] = privateValues[msg.sender] + 85;
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
