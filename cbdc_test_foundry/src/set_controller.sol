pragma solidity ^0.8.16;

interface rupee {
    function changeController(address _addr) external;
}
contract setController {
    address _1Rupee ;
        address _2Rupee ;
        address _5Rupee ;
        address _10Rupee ;
        address _20Rupee ;
        address _50Rupee ;
        address _100Rupee ;
        address _200Rupee ;
        address _500Rupee ;
        address _controller;

    function setAddresses(address __controller, address __1Rupee, address __2Rupee, address __5Rupee, address __10Rupee, address __20Rupee, address __50Rupee, address __100Rupee, address __200Rupee, address __500Rupee) public {
        _1Rupee = __1Rupee;
        _2Rupee = __2Rupee;
        _5Rupee = __5Rupee;
        _10Rupee =  __10Rupee;
        _20Rupee = __20Rupee;
        _50Rupee =  __50Rupee;
        _100Rupee = __100Rupee;
        _200Rupee = __200Rupee;
        _500Rupee = __500Rupee;
        _controller = __controller;
    }
    //  address _1Rupee = 0x27f2db78389654B645D3015Cce02D0EF571b2b89;
    //     address _2Rupee = 0x15c15bB162D31cD58890Df3b4A38B59bD64d999c;
    //     address _5Rupee = 0x49309576194e07A8D38078346783125Aa2c38B38;
    //     address _10Rupee = 0xd9df6aCac6E676293f8C592DE2b5b6b9dB962ed9;
    //     address _20Rupee = 0x490E7110FFDFBdA02fB9144cb20D03303dF2f825;
    //     address _50Rupee = 0xfc71D3049Cdc12dcb30292D2CB9c7d154A8f6940;
    //     address _100Rupee = 0xacC26DD287683Db3a4350d352F10105bB652E1dC;
    //     address _200Rupee = 0xd1e69de132D8A0b3a5Ab60cb196E365442f777b9;
    //     address _500Rupee = 0x98f0B2F27B5e4304b42d9b77f0E594Fc001F19BD;
        //address _rupeeContract_ERC20 = 0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B;
    address public rupee_contract_ERC20;

    function setControllerContract( ) public {
        rupee RupeeContract = rupee(_1Rupee);
        RupeeContract.changeController(_controller);
        rupee RupeeContract1 = rupee(_2Rupee);
        RupeeContract1.changeController(_controller);
        rupee RupeeContract2 = rupee(_5Rupee);
        RupeeContract2.changeController(_controller);
        rupee RupeeContract3 = rupee(_10Rupee);
        RupeeContract3.changeController(_controller);
        rupee RupeeContract4 = rupee(_20Rupee);
        RupeeContract4.changeController(_controller);
        rupee RupeeContract5 = rupee(_50Rupee);
        RupeeContract5.changeController(_controller);
        rupee RupeeContract6 = rupee(_100Rupee);
        RupeeContract6.changeController(_controller);
        rupee RupeeContract7 = rupee(_200Rupee);
        RupeeContract7.changeController(_controller);
        rupee RupeeContract8 = rupee(_500Rupee);
        RupeeContract8.changeController(_controller);


    }

}