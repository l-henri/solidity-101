pragma solidity >=0.4.22 <0.6.0;



/**

Kelsen Framework
Organ library
This library is used to hold all the logic to manage a simple organ.

**/
library organLibrary {
  
    struct Master {
        bool canAdd;  // if true, master can add admins
        bool canDelete;  // if true, master can delete admins
    }

    struct Admin {
        bool canAdd;  // if true, Admin can add norms
        bool canDelete;  // if true, Admin can delete norms
        bool canSpend;
        bool canDeposit;
    }

    struct Norm {
        address payable normAddress; // Address if norm is a member or a contract
        bytes32 ipfsHash; // ID of proposal on IPFS
        uint8 hash_function;
        uint8 size;
    }

    struct OrganInfo {
        bytes32 organName;
        uint256 activeNormNumber;
        mapping(address => Master) masters;
        mapping(address => Admin) admins;
        Norm[] norms;
        mapping(address => uint) addressPositionInNorms;
    }

    // Events
    // Organ management events
    event changeOrganName(address _from, bytes32 _newName);
    event spendMoney(address _from, address _to, uint256 _amount);
    event receiveMoney(address _from, uint256 _amount);

    // Master management events
    event addMasterEvent(address _from, address _newMaster, bool _canAdd, bool _canDelete);
    event remMasterEvent(address _from, address _masterToRemove);

    // Admin management events
    event addAdminEvent(address _from, address _newAdmin, bool _canAdd, bool _canDelete, bool _canDeposit, bool _canSpend);
    event remAdminEvent(address _from, address _adminToRemove);

    // Norm management events
    event addNormEvent(address _from, address _normAddress, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size);
    event remNormEvent(address _from, address _normAddress, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size);

    function initOrganLib(OrganInfo storage self, bytes32 _organName)
    public
    {
        // Initializing with deployer as master
        self.masters[msg.sender].canAdd = true;
        self.masters[msg.sender].canDelete = true;
        self.organName = _organName;
        Norm memory initNorm;
        self.norms.push(initNorm);
    }
    function setNameLib(OrganInfo storage self, bytes32 _organName) 
    public 
    {
        // Check sender is allowed
        require((self.masters[msg.sender].canAdd) && (self.masters[msg.sender].canDelete));
        self.organName = _organName;
        emit changeOrganName(msg.sender, _organName);
    }
        // Money managing function
    function payInLib(OrganInfo storage self) 
    public  
    {
        require(self.admins[msg.sender].canDeposit);
        emit receiveMoney(msg.sender, msg.value);
    }
    function payoutLib(OrganInfo storage self, address payable _to, uint _value) 
    public 
    {
        require(self.admins[msg.sender].canSpend);
        _to.transfer(_value);
        emit spendMoney(msg.sender, _to, _value);
    }
    // ################# Master managing functions
    function addMasterLib(OrganInfo storage self, address _newMasterAddress, bool _canAdd, bool _canDelete) 
    public
    {
        // Check that the sender is allowed
        require((self.masters[msg.sender].canAdd));
        // Check new master is not already a master
        require((!self.masters[_newMasterAddress].canAdd) && (!self.masters[_newMasterAddress].canDelete));

        // Check new master has at least one permission activated
        require(_canAdd || _canDelete);

        // Creating master privileges
        self.masters[_newMasterAddress].canAdd = _canAdd;
        self.masters[_newMasterAddress].canDelete = _canDelete;
        emit addMasterEvent(msg.sender, _newMasterAddress, _canAdd, _canDelete);
    }
    function remMasterLib(OrganInfo storage self, address _masterToRemove) 
    public 
    {
        // Check sender is allowed
        require((self.masters[msg.sender].canDelete));
        // Check affected account is a master
        require((self.masters[_masterToRemove].canDelete) || (self.masters[_masterToRemove].canAdd) );
        // Deleting master privileges
        delete self.masters[_masterToRemove];
        emit remMasterEvent(msg.sender, _masterToRemove);
    }
    function replaceMasterLib(OrganInfo storage self, address _masterToRemove, address _masterToAdd, bool _canAdd, bool _canDelete) 
    public 
    {
        // Check sender is allowed
        require((self.masters[msg.sender].canAdd) && (self.masters[msg.sender].canDelete));
        // Check new master has at least one permission activated
        require(_canAdd || _canDelete);

        // Check if we are replacing a master with another, or if we are modifying permissions
        if (_masterToRemove != _masterToAdd)
        {
            // Replacing a master
            addMasterLib(self, _masterToAdd, _canAdd, _canDelete);
            remMasterLib(self, _masterToRemove);
        }
        else
        {
            // Modifying permissions
            // Triggering events
            emit remMasterEvent(msg.sender, _masterToRemove);
            emit addMasterEvent(msg.sender, _masterToAdd, _canAdd, _canDelete);

            //Modifying permissions
            self.masters[_masterToRemove].canAdd = _canAdd;
            self.masters[_masterToRemove].canDelete = _canDelete;
        }
    }

    // ################# Admin managing functions
    function addAdminLib(OrganInfo storage self, address _newAdminAddress, bool _canAdd, bool _canDelete, bool _canDeposit, bool _canSpend) 
    public 
    {
        // Check the sender is allowed
        require((self.masters[msg.sender].canAdd));
        // Check new admin is not already an admin
        require((!self.admins[_newAdminAddress].canAdd) && (!self.admins[_newAdminAddress].canDelete) && (!self.admins[_newAdminAddress].canDeposit) && (!self.admins[_newAdminAddress].canSpend));

        // Check new admin has at least one permission activated
        require(_canAdd || _canDelete || _canDeposit || _canSpend);

        // Creating master privileges
        self.admins[_newAdminAddress].canAdd = _canAdd;
        self.admins[_newAdminAddress].canDelete = _canDelete;
        self.admins[_newAdminAddress].canDeposit = _canDeposit;
        self.admins[_newAdminAddress].canSpend = _canSpend;
        emit addAdminEvent(msg.sender, _newAdminAddress,  _canAdd,  _canDelete,  _canDeposit,  _canSpend);
    }

    function remAdminLib(OrganInfo storage self, address _adminToRemove) 
    public 
    {
        // Check sender is allowed
        require((self.masters[msg.sender].canDelete));
        // Check affected account is admin
        require((self.admins[_adminToRemove].canDelete) || (self.admins[_adminToRemove].canAdd) || (self.admins[_adminToRemove].canDeposit) || (self.admins[_adminToRemove].canSpend));

        // Deleting admin privileges
        delete self.admins[_adminToRemove];

        emit remAdminEvent(msg.sender, _adminToRemove);
    }

    function replaceAdminLib(OrganInfo storage self, address _adminToRemove, address _adminToAdd, bool _canAdd, bool _canDelete, bool _canDeposit, bool _canSpend) 
    public 
    {
        // Check sender is allowed
        require((self.masters[msg.sender].canAdd) && (self.masters[msg.sender].canDelete));
        // Check new admin has at least one permission activated
        require(_canAdd || _canDelete || _canDeposit || _canSpend);
        
        remAdminLib(self, _adminToRemove);
        addAdminLib(self, _adminToAdd, _canAdd, _canDelete, _canDeposit, _canSpend);
    }

    function addNormLib(OrganInfo storage self, address payable _normAddress, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size) 
    public 
    returns (uint _normPosition)
    {
        // Check sender is allowed
        require(self.admins[msg.sender].canAdd);

        // If the norm has an address, we check that the address has not been used before.
        if (_normAddress != address(0)) { require(self.addressPositionInNorms[_normAddress] == 0);}

        // Adding the norm
        self.norms.push(organLibrary.Norm({
                normAddress: _normAddress,
                ipfsHash: _ipfsHash,
                hash_function: _hash_function,
                size: _size
            }));
        // Registering norm position relative to its address
        self.addressPositionInNorms[_normAddress] = self.norms.length -1;
        // Incrementing active norm number and total norm number trackers
        self.activeNormNumber += 1;
        emit addNormEvent(msg.sender, _normAddress,  _ipfsHash,  _hash_function,  _size);

        // Registering the address as active
        return self.addressPositionInNorms[_normAddress] ;
    }

    function remNormLib(OrganInfo storage self, uint _normNumber) 
    public
    {
        // Check sender is allowed:
        // - Sender is admin
        // - Norm number is trying to delete himself
        require(self.admins[msg.sender].canDelete || (self.addressPositionInNorms[self.norms[_normNumber].normAddress] != 0 && msg.sender == self.norms[_normNumber].normAddress));
        // Deleting norm position from addressPositionInNorms
        delete self.addressPositionInNorms[self.norms[_normNumber].normAddress];
        // Logging event
        emit remNormEvent(msg.sender, self.norms[_normNumber].normAddress, self.norms[_normNumber].ipfsHash,  self.norms[_normNumber].hash_function,  self.norms[_normNumber].size);

        // Removing norm from norms
        delete self.norms[_normNumber];
        self.activeNormNumber -= 1;
    }

    function replaceNormLib(OrganInfo storage self, uint _normNumber, address payable _normAddress, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size) 
    public
    {
        require((self.admins[msg.sender].canDelete) && (self.admins[msg.sender].canAdd));
        if (_normAddress != address(0)) { require(self.addressPositionInNorms[_normAddress] != 0);}
        
        self.addressPositionInNorms[self.norms[_normNumber].normAddress] = 0;
        emit remNormEvent(msg.sender, self.norms[_normNumber].normAddress, self.norms[_normNumber].ipfsHash,  self.norms[_normNumber].hash_function,  self.norms[_normNumber].size);

        delete self.norms[_normNumber];
        self.norms[_normNumber] = organLibrary.Norm({
                normAddress: _normAddress,
                ipfsHash: _ipfsHash,
                hash_function: _hash_function,
                size: _size
            });
        
        self.addressPositionInNorms[_normAddress] = _normNumber;
        emit addNormEvent(msg.sender, _normAddress,  _ipfsHash,  _hash_function,  _size);
    }
}