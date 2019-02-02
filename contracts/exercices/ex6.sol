pragma solidity ^0.4.24;


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
contract ex6 is exerciceTemplate {

	mapping(address => uint) private privateValues;
  mapping(address => uint) public publicValues;
  uint[20] private randomValuesStore;
  uint public nextValueStoreRank;

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
    if (nextValueStoreRank >= randomValuesStore.length)
    {
     nextValueStoreRank = 0; 
    }
  }
  
  function duplicatePrivateValueInPublic() 
  public 
  canWorkOnExercice 
  {
    publicValues[msg.sender] = privateValues[msg.sender] + 85;
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
