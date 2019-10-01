pragma solidity >=0.4.22 <0.6.0;

// Standard contract for a presidential election procedure

import "../standardProcedure.sol";
import "../Organ.sol";

contract simpleNormNominationProcedure is Procedure{

    // 1: Cyclical many to one election (Presidential Election)
    // 2: Cyclical many to many election (Moderators Election)
    // 3: Simple norm nomination 
    // 4: Simple admins and master nomination
    // 5: Vote on Norms 
    // 6: Vote on masters and admins 
    // 7: Cooptation

    using procedureLibrary for procedureLibrary.oneRegisteredOrgan;
    // First stakeholder address is authorizedNominatersOrgan
    procedureLibrary.oneRegisteredOrgan public linkedOrgans;
    
    constructor (address payable _authorizedNominatersOrgan, bytes32 _name) 
    public
    {
        procedureInfo.initProcedure(3, _name, 1);
        linkedOrgans.initOneRegisteredOrgan(_authorizedNominatersOrgan);
    }

    function addNorm(address payable _targetOrgan, address payable _normAdress, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size)  
    public 
    returns (uint newNormNumber) 
    {
        // Checking if caller is an admin
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);

        // Sending the addNorm command to the desired organ. If the nomination procedure is not an admin, the call will fail
        Organ targetOrganInstance = Organ(_targetOrgan);
        return targetOrganInstance.addNorm(_normAdress, _ipfsHash, _hash_function, _size);
    }

    function remNorm(address payable _targetOrgan, uint _normNumber) 
    public 
    {
        // Checking if caller is an admin
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);

        // Sending the addNorm command to the desired organ. If the nomination procedure is not an admin, the call will fail
        Organ targetOrganInstance = Organ(_targetOrgan);
        targetOrganInstance.remNorm(_normNumber);
    }

    function replaceNorm(address payable _targetOrgan, uint _oldNormNumber, address payable _newNormAdress, bytes32 _ipfsHash, uint8 _hash_function, uint8 _size) 
    public 
    {
        // Checking if caller is an admin
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);

        // Sending the replaceNorm command to the desired organ. If the nomination procedure is not an admin, the call will fail
        Organ targetOrganInstance = Organ(_targetOrgan);
        targetOrganInstance.replaceNorm(_oldNormNumber, _newNormAdress, _ipfsHash, _hash_function, _size);        
    }
}