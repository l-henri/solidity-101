pragma solidity >=0.4.22 <0.6.0;

import "../Organ.sol";

/**

Kelsen Framework
Procedure library
This library is used to hold the logic common to all procedures

**/
library procedureLibrary {
  
    struct ProcedureData 
    {
        uint procedureTypeNumber;
        bytes32 procedureName;
        uint linkedOrgans;
    }

    struct oneRegisteredOrgan
    {
        address payable firstOrganAddress;
    }

    struct twoRegisteredOrgans
    {
        address payable firstOrganAddress;
        address payable secondOrganAddress;
    }

    struct threeRegisteredOrgans
    {
        address payable firstOrganAddress;
        address payable secondOrganAddress;
        address payable thirdOrganAddress;
    }

    struct fourRegisteredOrgans
    {
        address payable firstOrganAddress;
        address payable secondOrganAddress;
        address payable thirdOrganAddress;
        address payable fourthOrganAddress;
    }

    function initProcedure(ProcedureData storage self, uint _procedureTypeNumber, bytes32 _procedureName, uint _linkedOrgans)
    public
    {
        self.procedureTypeNumber = _procedureTypeNumber;
        self.procedureName = _procedureName;
        self.linkedOrgans = _linkedOrgans;
    }

    function initOneRegisteredOrgan(oneRegisteredOrgan storage self, address payable _firstOrganAddress)
    public
    {
        self.firstOrganAddress = _firstOrganAddress;
    }

    function initTwoRegisteredOrgans(twoRegisteredOrgans storage self, address payable _firstOrganAddress, address payable _secondOrganAddress)
    public
    {
        self.firstOrganAddress = _firstOrganAddress;
        self.secondOrganAddress = _secondOrganAddress;
    }

    function initThreeRegisteredOrgans(threeRegisteredOrgans storage self, address payable _firstOrganAddress, address payable _secondOrganAddress, address payable _thirdOrganAddress)
    public
    {
        self.firstOrganAddress = _firstOrganAddress;
        self.secondOrganAddress = _secondOrganAddress;
        self.thirdOrganAddress = _thirdOrganAddress;
    }

    function initFourRegisteredOrgans(fourRegisteredOrgans storage self, address payable _firstOrganAddress, address payable _secondOrganAddress, address payable _thirdOrganAddress, address payable _fourthOrganAddress)
    public
    {
        self.firstOrganAddress = _firstOrganAddress;
        self.secondOrganAddress = _secondOrganAddress;
        self.thirdOrganAddress = _thirdOrganAddress;
        self.fourthOrganAddress = _fourthOrganAddress;
    }

    function isAllowed(address payable _organAddress)
    internal
    view
    {
      // Verifying the evaluator is an admin
      Organ authorizedUsersOrgan = Organ(_organAddress);

      require(authorizedUsersOrgan.getAddressPositionInNorm(msg.sender) != 0);
      delete _organAddress;
    }

}