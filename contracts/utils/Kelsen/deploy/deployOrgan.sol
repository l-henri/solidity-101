pragma solidity ^0.4.11;

/// @title Standard organ contract


import "../standardOrgan.sol";

contract deployOrgan is Organ {

    function deployOrgan (string _name) public {

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
}