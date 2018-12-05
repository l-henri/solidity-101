pragma solidity ^0.4.24;


import "../exerciceTemplate.sol";

/*
Exercice 8: structures
In this exercice, you need to:
- Create an object using a structure
- Modify it
- Claim your points
- Your points are credited by the contract
*/

/*
What you need to know to complete this exercice
A) What was included in the previous exercices
B) What a structure is https://solidity.readthedocs.io/en/develop/types.html#index-14

*/
contract ex8 is exerciceTemplate {

	struct studentObject 
  {
    address owner;
    address creator;
    string name;
    bool hasBeenModified;
  }

  studentObject[] public studentObjects;
  
  event createdAnObject(uint objectNumber);

  constructor(address _studentsOrganAddres, address _teachersOrganAddress, address _pointsManagerContractAddress) 
  exerciceTemplate(_studentsOrganAddres, _teachersOrganAddress, _pointsManagerContractAddress) 
  public
  {}

  function createObject(string _name) 
  public 
  canWorkOnExercice 
  {

    studentObject memory _studentObject;
    _studentObject.owner = msg.sender;
    _studentObject.creator = msg.sender;
    _studentObject.name = _name;
    _studentObject.hasBeenModified = false;

    studentObjects.push(_studentObject) - 1;
    uint objectNumber = studentObjects.length - 1;

    emit createdAnObject(objectNumber);

  }
  
  function changeObjectName(uint _objectNumber, string _name) 
  public 
  canWorkOnExercice 
  {
    require(studentObjects[_objectNumber].owner == msg.sender);
    studentObjects[_objectNumber].name = _name;
    studentObjects[_objectNumber].hasBeenModified = true;
  }

  function transfer(uint _objectNumber, address _recipient) 
  public  
  {
    require(studentObjects[_objectNumber].owner == msg.sender);
    studentObjects[_objectNumber].owner = _recipient;
  }


  function claimPoints(uint _objectNumber) 
  public 
  canWorkOnExercice 
  {
    require(studentObjects[_objectNumber].creator == msg.sender);
    require(studentObjects[_objectNumber].hasBeenModified == true);

    Organ teachersOrganInstance = Organ(teachersOrganAddress);
    require(teachersOrganInstance.isNorm(studentObjects[_objectNumber].owner));

    // Validating exercice
    validateExercice(msg.sender);
    creditStudent(200, msg.sender);

  }

}
