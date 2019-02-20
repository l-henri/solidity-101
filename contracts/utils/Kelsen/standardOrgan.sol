pragma solidity >=0.4.22 <0.6.0;


/// @title Standard organ contract


import "./Kelsen.sol";


contract Organ is Kelsen{


    // Declaring structures for different organ roles:
    // Masters can add/remove admins
    // Admins can add / remove norms
    // Norms are sets of adresses, contracts or references gathered by the organ
    bool public isAnOrgan = true;
    bool public isAProcedure = false;
    int public kelsenVersionNumber = 1;
    string public organName;

    struct Master {
        string name; // Master name
        bool canAdd;  // if true, master can add admins
        bool canDelete;  // if true, master can delete admins
        uint rankInMasterList; // Rank in dynamic array masterList

    }

    struct Admin {
        string name; // Admin name
        bool canAdd;  // if true, Admin can add norms
        bool canDelete;  // if true, Admin can delete norms
        bool canSpend;
        bool canDeposit;
        uint rankInAdminList; // Rank in dynamic array adminList
    }

    struct Norm {
        string name; // Master name
        address normAddress; // Address if norm is a member or a contract
        bytes32 ipfsHash; // ID of proposal on IPFS
        uint8 hash_function;
        uint8 size;
    }

    // Events
    // Organ management events
    event changeOrganName(address _from, string _newName);
    event spendMoney(address _from, address _to, uint256 _amount);
    event receiveMoney(address _from, uint256 _amount);

    // Master management events
    event addMasterEvent(address _from, address _newMaster, bool _canAdd, bool _canDelete, string _name);
    event remMasterEvent(address _from, address _masterToRemove);

    // Admin management events
    event addAdminEvent(address _from, address _newAdmin, bool _canAdd, bool _canDelete, bool _canDeposit, bool _canSpend, string _name);
    event remAdminEvent(address _from, address _adminToRemove);

    // Norm management events
    event addNormEvent(address _from, address _normAddress, string _name, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size);
    event remNormEvent(address _from, address _normAddress, string _name, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size);



    // This declares two state variable that
    // stores a `Master` and a 'admin' struct for each possible address.
    mapping(address => Master) public masters;
    mapping(address => Admin) public admins;

    // One mapping to signal adresses that are included in norms
    mapping(address => bool) public isAddressInNorms;
    // One mapping to track norm position of each address. Careful, each address is tracked only once here
    mapping(address => uint) public addressPositionInNorms;

    // This declares two dynamically-sized array of `Admin` and 'Master' structs for easy referencing.
    address[] public masterList;
    address[] public adminList;

    // A dynamically-sized array of `Norm` structs.
    Norm[] public norms;


    // Keeping track of active norms
    uint256 public activeNormNumber;


    constructor(string _name) public {

        // Initializing with deployer as master
        masters[msg.sender].canAdd = true;
        masters[msg.sender].canDelete = true;
        masters[msg.sender].name = 'Original Master';
        masterList.push(msg.sender);
        organName = _name;
        // Initializing with deployer as admin
        // admins[msg.sender].canAdd = true;
        // admins[msg.sender].canDelete = true;
        // admins[msg.sender].name = 'Original Master';
        // adminList.push(msg.sender);
        // Initializing first norms to avoid errors when deleting norms
        Norm memory initNorm;
        norms.push(initNorm);
        kelsenVersionNumber = 1;

    }
    // ################# Organ managing functions

    function setName(string _name) public {
        // Check sender is allowed
        require((masters[msg.sender].canAdd) && (masters[msg.sender].canDelete));
        organName = _name;
        emit changeOrganName(msg.sender, _name);
    }
        // Money managing function
    function () public payable {
        require(admins[msg.sender].canDeposit);
        emit receiveMoney(msg.sender, msg.value);


    }
    function payout(address _to, uint _value) public {
        require(admins[msg.sender].canSpend);
        _to.transfer(_value);
        emit spendMoney(msg.sender, _to, _value);
    }

    // ################# Master managing functions

    function addMaster(address _newMasterAddress, bool _canAdd, bool _canDelete, string _name) public{
        // Check that the sender is allowed
        require((masters[msg.sender].canAdd));
        // Check new master is not already a master
        require((!masters[_newMasterAddress].canAdd) && (!masters[_newMasterAddress].canDelete));

        // Check new master has at least one permission activated
        require(_canAdd || _canDelete);

        // Adding master to master list and retrieving position
        masters[_newMasterAddress].rankInMasterList = masterList.push(_newMasterAddress) - 1;

        // Creating master privileges
        masters[_newMasterAddress].canAdd = _canAdd;
        masters[_newMasterAddress].canDelete = _canDelete;
        masters[_newMasterAddress].name = _name;
        emit addMasterEvent(msg.sender, _newMasterAddress, _canAdd, _canDelete, _name);

    }

    function replaceMaster(address _masterToRemove, address _masterToAdd, bool _canAdd, bool _canDelete, string _name) public {
        // Check sender is allowed
        require((masters[msg.sender].canAdd) && (masters[msg.sender].canDelete));
        // Check new master has at least one permission activated
        require(_canAdd || _canDelete);

        // Check if we are replacing a master with another, or if we are modifying permissions
        if (_masterToRemove != _masterToAdd)
        {
            // Replacing a master
            addMaster(_masterToAdd, _canAdd, _canDelete, _name);
            remMaster(_masterToRemove);
        }

        else
        {
            // Modifying permissions
            

            // Triggering events
            emit remMasterEvent(msg.sender, _masterToRemove);
            emit addMasterEvent(msg.sender, _masterToAdd, _canAdd, _canDelete, _name);

            //Modifying permissions
            masters[_masterToRemove].canAdd = _canAdd;
            masters[_masterToRemove].canDelete = _canDelete;
            masters[_masterToRemove].name = _name;

        }


    }
    function remMaster(address _masterToRemove) public {
        // Check sender is allowed
        require((masters[msg.sender].canDelete));
        // Check affected account is a master
        require((masters[_masterToRemove].canDelete) || (masters[_masterToRemove].canAdd) );
        // Deleting entry in masterList
        delete masterList[masters[_masterToRemove].rankInMasterList];
        // Deleting master privileges
        delete masters[_masterToRemove];
        emit remMasterEvent(msg.sender, _masterToRemove);
    }

    // ################# Admin managing functions

    function addAdmin(address _newAdminAddress, bool _canAdd, bool _canDelete, bool _canDeposit, bool _canSpend, string _name) public {
        // Check the sender is allowed
        require((masters[msg.sender].canAdd));
        // Check new admin is not already an admin
        require((!admins[_newAdminAddress].canAdd) && (!admins[_newAdminAddress].canDelete) && (!admins[_newAdminAddress].canDeposit) && (!admins[_newAdminAddress].canSpend));

        // Check new admin has at least one permission activated
        require(_canAdd || _canDelete || _canDeposit || _canSpend);

        // Adding admin to admin list and retrieving position
        admins[_newAdminAddress].rankInAdminList = adminList.push(_newAdminAddress) - 1;

        // Creating master privileges
        admins[_newAdminAddress].canAdd = _canAdd;
        admins[_newAdminAddress].canDelete = _canDelete;
        admins[_newAdminAddress].canDeposit = _canDeposit;
        admins[_newAdminAddress].canSpend = _canSpend;
        admins[_newAdminAddress].name = _name;
        emit addAdminEvent(msg.sender, _newAdminAddress,  _canAdd,  _canDelete,  _canDeposit,  _canSpend,  _name);
   
    }

    function replaceAdmin(address _adminToRemove, address _adminToAdd, bool _canAdd, bool _canDelete, bool _canDeposit, bool _canSpend, string _name) public {
        // Check sender is allowed
        require((masters[msg.sender].canAdd) && (masters[msg.sender].canDelete));
        // Check new admin has at least one permission activated
        require(_canAdd || _canDelete || _canDeposit || _canSpend);
        
        remAdmin(_adminToRemove);
        addAdmin(_adminToAdd, _canAdd, _canDelete, _canDeposit, _canSpend, _name);

    }

    function remAdmin(address _adminToRemove) public {
        // Check sender is allowed
        require((masters[msg.sender].canDelete));
        // Check affected account is admin
        require((admins[_adminToRemove].canDelete) || (admins[_adminToRemove].canAdd) );
        // Deleting entry in adminList
        delete adminList[admins[_adminToRemove].rankInAdminList];
        // Deleting admin privileges
        delete admins[_adminToRemove];

        emit remAdminEvent(msg.sender, _adminToRemove);

    }

    // ################# Norms managing functions

    function addNorm (address _normAddress, string _name, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size) public  returns (uint _normPosition)
    {
        // Check sender is allowed
        require(admins[msg.sender].canAdd);

        // If the norm has an address, we check that the address has not been used before.
        if (_normAddress != 0x0000) { require(!isAddressInNorms[_normAddress]);}

        // Adding the norm
        norms.push(Norm({
                name: _name,
                normAddress: _normAddress,
                ipfsHash: _ipfsHash,
                hash_function: _hash_function,
                size: _size
            }));
        // Registering norm position relative to its address
        addressPositionInNorms[_normAddress] = norms.length -1;
        // Incrementing active norm number and total norm number trackers
        activeNormNumber = activeNormNumber + 1;
        emit addNormEvent(msg.sender, _normAddress,  _name,  _ipfsHash,  _hash_function,  _size);

        // Registering the address as active
        isAddressInNorms[_normAddress] = true;
        return addressPositionInNorms[_normAddress] ;
    }

    function replaceNorm (uint _normNumber, address _normAddress, string _name, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size) public
    {
        require((admins[msg.sender].canDelete) && (admins[msg.sender].canAdd));
        if (_normAddress != 0x0000) { require(!isAddressInNorms[_normAddress]);}
        isAddressInNorms[norms[_normNumber].normAddress] = false;
        addressPositionInNorms[norms[_normNumber].normAddress] = 0;
        emit remNormEvent(msg.sender, norms[_normNumber].normAddress, norms[_normNumber].name, norms[_normNumber].ipfsHash,  norms[_normNumber].hash_function,  norms[_normNumber].size);

        delete norms[_normNumber];
        norms[_normNumber] = Norm({
                name: _name,
                normAddress: _normAddress,
                ipfsHash: _ipfsHash,
                hash_function: _hash_function,
                size: _size
            });
        isAddressInNorms[_normAddress] = true;
        addressPositionInNorms[_normAddress] = _normNumber;
        emit addNormEvent(msg.sender, _normAddress,  _name,  _ipfsHash,  _hash_function,  _size);

    }

    function remNorm (uint _normNumber) public
    {
        // Check sender is allowed:
        // - Sender is admin
        // - Norm number is trying to delete himself
        require(admins[msg.sender].canDelete || (isAddressInNorms[msg.sender] && msg.sender == norms[_normNumber].normAddress));
        // Deleting norm position from addressPositionInNorms
        delete addressPositionInNorms[norms[_normNumber].normAddress];
        // Marking address as deactivated from isAddressInNorms
        isAddressInNorms[norms[_normNumber].normAddress] = false;
        // Logging event
        emit remNormEvent(msg.sender, norms[_normNumber].normAddress, norms[_normNumber].name, norms[_normNumber].ipfsHash,  norms[_normNumber].hash_function,  norms[_normNumber].size);

        // Removing norm from norms
        delete norms[_normNumber];
        activeNormNumber = activeNormNumber - 1;


    }

    //////////////////////// Functions to communicate with other contracts
    // Checking individual addresses
    function isMaster (address _adressToCheck) public view returns (bool canAdd, bool canDelete) {
        return (masters[_adressToCheck].canAdd, masters[_adressToCheck].canDelete);
    }
    function isAdmin (address _adressToCheck) public view returns (bool canAdd, bool canDelete) {
        return (admins[_adressToCheck].canAdd, admins[_adressToCheck].canDelete);
    }
    function isNorm (address _adressToCheck) public view returns (bool isAddressInNorm) {
        return isAddressInNorms[_adressToCheck];
    }
    function isMoneyManager(address _adressToCheck) public view returns (bool canDeposit, bool canSpend){
        return (admins[_adressToCheck].canDeposit, admins[_adressToCheck].canSpend);
    }
    // Retrieve contract state info
    // Number of active norms (voter pool size for voter registering, for example)
    function getActiveNormNumber() public view returns (uint _activeNormNumber){
        return activeNormNumber;
    }
    // Size of norm array, to list elements
    function getNormListSize() public view returns (uint normArraySize){
        return norms.length;
    }
    function getAddressPositionInNorm(address _addressToCheck) public view returns (uint addressInNormPosition){
        return addressPositionInNorms[_addressToCheck];
    }
    function getSingleNorm(uint _desiredNormPosition) public view returns (string name, address normAddress, bytes32 ipfsHash, uint8 hash_function, uint8 size){
        return (norms[_desiredNormPosition].name, norms[_desiredNormPosition].normAddress, norms[_desiredNormPosition].ipfsHash, norms[_desiredNormPosition].hash_function, norms[_desiredNormPosition].size);
    }

    // Retrieve lists of adresses
    function getMasterList() public view returns (address[] _masterList){
        return masterList;
    }
    function getAdminList() public view returns (address[] _adminList){
        return adminList;
    }
    function getKelsenVersion() public view returns(bool _isAnOrgan, bool _isAProcedure, int _versionNumber)
    {

        return (isAnOrgan, isAProcedure, kelsenVersionNumber);

    }



}