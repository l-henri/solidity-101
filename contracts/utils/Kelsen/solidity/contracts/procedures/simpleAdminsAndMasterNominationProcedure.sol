pragma solidity >=0.4.22 <0.6.0;


// Standard contract for a presidential election procedure

import "../standardProcedure.sol";
import "../Organ.sol";

contract simpleAdminsAndMasterNominationProcedure is Procedure{

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
    

    constructor(address payable _authorizedNominatersOrgan, bytes32 _name) 
    public 
    {
        procedureInfo.initProcedure(4, _name, 1);
        linkedOrgans.initOneRegisteredOrgan(_authorizedNominatersOrgan);
    }

    function addAdmin(address payable _organToReform, address _newAdmin, bool _canAdd, bool _canDelete, bool _canDeposit, bool _canSpend) 
    public 
    {
        // Checking if caller is an admin
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);

        // Sending the required command to the desired organ. If the nomination procedure is not an admin, the call will fail
        Organ organToReformInstance = Organ(_organToReform);
        organToReformInstance.addAdmin(_newAdmin, _canAdd, _canDelete, _canDeposit, _canSpend);
    }

    function remAdmin(address payable _organToReform, address _oldAdmin) 
    public 
    {
        // Checking if caller is an admin
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);

        // Sending the required command to the desired organ. If the nomination procedure is not an admin, the call will fail
        Organ organToReformInstance = Organ(_organToReform);
        organToReformInstance.remAdmin(_oldAdmin);
    }

    function replaceAdmin(address payable _organToReform, address _oldAdmin, address _newAdmin, bool _canAdd, bool _canDelete, bool _canDeposit, bool _canSpend) 
    public 
    {
        // Checking if caller is an admin
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);

        // Sending the required command to the desired organ. If the nomination procedure is not an admin, the call will fail
        Organ organToReformInstance = Organ(_organToReform);
        organToReformInstance.replaceAdmin(_oldAdmin, _newAdmin, _canAdd, _canDelete, _canDeposit, _canSpend );
    }

    function addMaster(address payable _organToReform, address _newMaster, bool _canAdd, bool _canDelete) 
    public 
    {
        // Checking if caller is an admin
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);

        // Sending the required command to the desired organ. If the nomination procedure is not an admin, the call will fail
        Organ organToReformInstance = Organ(_organToReform);
        organToReformInstance.addMaster(_newMaster, _canAdd, _canDelete);
    }

    function remMaster(address payable _organToReform, address _oldMaster) 
    public 
    {

        // Checking if caller is an admin
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);
                
        // Sending the required command to the desired organ. If the nomination procedure is not an admin, the call will fail
        Organ organToReformInstance = Organ(_organToReform);
        organToReformInstance.remMaster(_oldMaster);
    }

    function replaceMaster(address payable _organToReform, address _oldMaster, address _newMaster, bool _canAdd, bool _canDelete) 
    public 
    {
        // Checking if caller is an admin
        procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);
        
        // Sending the required command to the desired organ. If the nomination procedure is not an admin, the call will fail
        Organ organToReformInstance = Organ(_organToReform);
        organToReformInstance.replaceMaster(_oldMaster, _newMaster, _canAdd, _canDelete);
    }
}