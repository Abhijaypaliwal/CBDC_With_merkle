pragma solidity ^0.8.19;

import "./5_Rupee.sol";
contract MomContract {

    //DaughterContract public daughter;
    _20Rupee public TwentyRupee;
    _50Rupee public FiftyRupee;
    _100Rupee public HundredRupee;
    _200Rupee public TwoHundredRupee;
    _500Rupee public FiveHundredRupee;
    


    constructor() public {
         TwentyRupee = new _20Rupee(msg.sender);
        FiftyRupee = new _50Rupee(msg.sender);
        HundredRupee = new _100Rupee(msg.sender);
        TwoHundredRupee = new _200Rupee(msg.sender);
        FiveHundredRupee = new _500Rupee(msg.sender);
       
    }

    
}
