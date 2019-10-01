pragma solidity >=0.4.22 <0.6.0;


/// @title Standard organ contract


import "./Kelsen.sol";
import "./libraries/organLibrary.sol";


contract Organ is Kelsen{


    // Declaring structures for different organ roles:
    // Masters can add/remove admins
    // Admins can add / remove norms
    // Norms are sets of adresses, contracts or references gathered by the organ
    bool public isAnOrgan = true;
    bool public isAProcedure = false;
    
    using organLibrary for organLibrary.OrganInfo;
    // Storing organ infos
    organLibrary.OrganInfo public organInfos;

    // Organ declaration
    constructor(bytes32 _organName) public {
        organInfos.initOrganLib(_organName);
    }

    // ################# Organ managing functions

    function setName(bytes32 _organName) 
    public 
    {
        organInfos.setNameLib(_organName);
    }
        // Money managing function
    function () 
    external 
    payable 
    {
        organInfos.payInLib();
    }

    function payout(address payable _to, uint _value) 
    public 
    {
        organInfos.payoutLib(_to, _value);
    }

    // ################# Master managing functions
    function addMaster(address _newMasterAddress, bool _canAdd, bool _canDelete) 
    public
    {
        organInfos.addMasterLib(_newMasterAddress, _canAdd, _canDelete);
    }

    function remMaster(address _masterToRemove) 
    public 
    {
        organInfos.remMasterLib(_masterToRemove);
    }

    function replaceMaster(address _masterToRemove, address _masterToAdd, bool _canAdd, bool _canDelete) 
    public 
    {
        organInfos.replaceMasterLib(_masterToRemove, _masterToAdd, _canAdd, _canDelete);
    }

    // ################# Admin managing functions
    function addAdmin(address _newAdminAddress, bool _canAdd, bool _canDelete, bool _canDeposit, bool _canSpend) 
    public 
    {
        organInfos.addAdminLib(_newAdminAddress, _canAdd, _canDelete, _canDeposit, _canSpend);
    }

    function replaceAdmin(address _adminToRemove, address _adminToAdd, bool _canAdd, bool _canDelete, bool _canDeposit, bool _canSpend) 
    public 
    {
        organInfos.replaceAdminLib(_adminToRemove, _adminToAdd, _canAdd, _canDelete, _canDeposit, _canSpend);
    }

    function remAdmin(address _adminToRemove) public {
        organInfos.remAdminLib(_adminToRemove);
    }

    // ################# Norms managing functions

    function addNorm (address payable _normAddress, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size) 
    public  
    returns (uint _normPosition)
    {
        return organInfos.addNormLib(_normAddress, _ipfsHash, _hash_function, _size);
    }

    function remNorm (uint _normNumber) 
    public
    {
       organInfos.remNormLib(_normNumber);
    }

    function replaceNorm (uint _normNumber, address payable _normAddress, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size) 
    public
    {
       organInfos.replaceNormLib(_normNumber, _normAddress, _ipfsHash, _hash_function, _size);
    }

    //////////////////////// Functions to communicate with other contracts
    // Checking individual addresses
    function isMaster (address _adressToCheck) 
    public 
    view 
    returns (bool canAdd, bool canDelete) 
    {
        return (organInfos.masters[_adressToCheck].canAdd, organInfos.masters[_adressToCheck].canDelete);
    }

    function isAdmin (address _adressToCheck) 
    public 
    view 
    returns (bool canAdd, bool canDelete, bool canDeposit, bool canSpend) 
    {
        return (organInfos.admins[_adressToCheck].canAdd, organInfos.admins[_adressToCheck].canDelete, organInfos.admins[_adressToCheck].canDeposit, organInfos.admins[_adressToCheck].canSpend);
    }

    // Retrieve contract state info
    // Size of norm array, to list elements
    function getNormListSize() 
    public 
    view 
    returns (uint normArraySize)
    {
        return organInfos.norms.length;
    }

    function getAddressPositionInNorm(address _addressToCheck) 
    public 
    view 
    returns (uint addressInNormPosition)
    {
        return organInfos.addressPositionInNorms[_addressToCheck];
    }

    function getSingleNorm(uint _desiredNormPosition) 
    public 
    view 
    returns (address payable normAddress, bytes32 ipfsHash, uint8 hash_function, uint8 size)
    {
        return (organInfos.norms[_desiredNormPosition].normAddress, organInfos.norms[_desiredNormPosition].ipfsHash, organInfos.norms[_desiredNormPosition].hash_function, organInfos.norms[_desiredNormPosition].size);
    }

    function getKelsenVersion() 
    public 
    view 
    returns(bool _isAnOrgan, bool _isAProcedure, int _versionNumber)
    {
        return (isAnOrgan, isAProcedure, kelsenVersionNumber);
    }
}

