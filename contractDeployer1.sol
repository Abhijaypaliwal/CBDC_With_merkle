pragma solidity ^0.8.19;

import {_1Rupee} from "./5_Rupee.sol";
import {_2Rupee} from "./5_Rupee.sol";
import {_5Rupee} from "./5_Rupee.sol";
import {_10Rupee} from "./5_Rupee.sol";
import {_20Rupee} from "./5_Rupee.sol";
import {_50Rupee} from "./5_Rupee.sol";
import {_100Rupee} from "./5_Rupee.sol";
import {_200Rupee} from "./5_Rupee.sol";
import {_500Rupee} from "./5_Rupee.sol";
contract MomContract {

    //DaughterContract public daughter;
    _1Rupee public OneRupee;
    _2Rupee public TwoRupee;
    _5Rupee public FiveRupee;
    //_10Rupee public TenRupee;
    


    constructor() public {
        OneRupee = new _1Rupee(msg.sender);
        TwoRupee = new _2Rupee(msg.sender);
        FiveRupee = new _5Rupee(msg.sender);
       // TenRupee = new _10Rupee(msg.sender);
       
       
    }

    
}
contract MomContract2 {

    //DaughterContract public daughter;
    
    _10Rupee public TenRupee;
    _20Rupee public TwentyRupee;
    _50Rupee public FiftyRupee;
    


    constructor() public {
        
       TenRupee = new _10Rupee(msg.sender);
       TwentyRupee = new _20Rupee(msg.sender);
       FiftyRupee = new _50Rupee(msg.sender);
       
       
    }

    
}
contract MomContract3 {

    //DaughterContract public daughter;
    
    _100Rupee public HundredRupee;
    _200Rupee public TwoHundredRupee;
    _500Rupee public FiveHundredRupee;
    


    constructor() public {
        
       HundredRupee = new _100Rupee(msg.sender);
       TwoHundredRupee = new _200Rupee(msg.sender);
       FiveHundredRupee = new _500Rupee(msg.sender);
       
       
    }

    
}
