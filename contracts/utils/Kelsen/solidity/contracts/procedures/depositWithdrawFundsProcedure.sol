pragma solidity >=0.4.22 <0.6.0;

// Standard contract for promulgation of a norm

import "../standardProcedure.sol";
import "../Organ.sol";


contract depositWithdrawFundsProcedure is Procedure{
    // 1: Cyclical many to one election (Presidential Election)
    // 2: Cyclical many to many election (Moderators Election)
    // 3: Simple norm nomination 
    // 4: Simple admins and master nomination
    // 5: Vote on Norms 
    // 6: Vote on masters and admins 
    // 7: Cooptation
    // 8: Vote on an expense
    // 9: Deposit/Withdraw funds on an organ

    using procedureLibrary for procedureLibrary.threeRegisteredOrgans;

    // First stakeholder address is authorizedDepositorsOrganContract
    // Second stakeholder address is authorizedWithdrawersOrganContract
    // Third stakeholder address is defaultReceivingOrganContract
    procedureLibrary.threeRegisteredOrgans public linkedOrgans;

    // Events
    event depositedFunds(address _from, address _payoutAddress, uint _amount);
    event withdrewFunds(address _from, address _payoutAddress, uint _amount);

    constructor (address payable _authorizedDepositors, address payable _authorizedWithdrawers, address payable _defaultReceivingOrgan, bytes32 _name) 
    public 
    {
        procedureInfo.initProcedure(9, _name, 3);
        linkedOrgans.initThreeRegisteredOrgans(_authorizedDepositors, _authorizedWithdrawers, _defaultReceivingOrgan);
    }

    function () 
    external 
    payable 
    {
        depositToOrgan(linkedOrgans.thirdOrganAddress);
    }

    function depositToOrgan(address payable _targetOrgan) 
    public 
    payable 
    {
        // Checking if depositors are restricted
        if (linkedOrgans.firstOrganAddress != address(0)) 
        {
            procedureLibrary.isAllowed(linkedOrgans.firstOrganAddress);   
        }

        // Sending funds to organ
        _targetOrgan.transfer(msg.value);

        // Log event
        emit depositedFunds(msg.sender, _targetOrgan, msg.value);
    }

    function withdrawOnOrgan(address payable _targetOrgan, address payable _receiver, uint _amount) 
    public 
    {

        // Checking if withdrawers are restricted
        procedureLibrary.isAllowed(linkedOrgans.secondOrganAddress);    
   
        // Instanciating target organ for withdrawal
        Organ organToWithdrawFrom = Organ(_targetOrgan);

        // Withdrawing funds from organ
        organToWithdrawFrom.payout(_receiver, _amount);

        // Log event
        emit withdrewFunds( _targetOrgan, msg.sender, _amount);
    }
}

