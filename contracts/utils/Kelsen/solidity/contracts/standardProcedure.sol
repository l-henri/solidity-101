pragma solidity >=0.4.22 <0.6.0;


/// @title Standard organ contract

import "./Kelsen.sol";
import "./libraries/procedureLibrary.sol";


contract Procedure is Kelsen {

    procedureLibrary.ProcedureData public procedureInfo;
    using procedureLibrary for address;
    using procedureLibrary for procedureLibrary.ProcedureData;

    // Identifiers to adapt procedure interface
    bool public isAnOrgan = false;
    bool public isAProcedure = true;
}
