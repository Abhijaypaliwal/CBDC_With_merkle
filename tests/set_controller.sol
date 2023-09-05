pragma solidity ^0.8.16;

interface rupee {
    function changeController(address _addr) external;
}
contract setController {

    address public one_Rupee_contract = 0x2f915317f61A77ae6bBa3F7F74156082629aB0F2;
    address public two_Rupee_contract = 0xB9Cba4a0871a774d285B618aD5b0D849236C4c21;
    address public five_Rupee_contract = 0x2516321B0Fc5fb566e15af703B2F0C97D6dfA6C4;
    address public ten_Rupee_contract = 0xEa0A9687e725e5487212bE01C5e4635F710f8154;
    address public twenty_Rupee_contract = 0xa32B15769E6D73d9bf63b60ACdE159c0a6FBdAD0;
    address public fifty_Rupee_contract = 0xbede57e7091881ea08116749db18caA9F1fD0Ce3;
    address public one_hundred_Rupee_contract = 0xd1DCDCc1552712991868594B76240cA9D40b3036;
    address public two_hundred_Rupee_contract = 0x7FF2972f0AcF852773C10f53093659D5E5d89A7F;
    address public five_hundred_Rupee_contract = 0x4f23C98457A2a7e5C6CC3A9C3D8c865c74dd00CA;
    address public rupee_contract_ERC20;

    function setControllerContract(address _controller) public {
        rupee RupeeContract = rupee(one_Rupee_contract);
        RupeeContract.changeController(_controller);
        rupee RupeeContract1 = rupee(two_Rupee_contract);
        RupeeContract1.changeController(_controller);
        rupee RupeeContract2 = rupee(five_Rupee_contract);
        RupeeContract2.changeController(_controller);
        rupee RupeeContract3 = rupee(ten_Rupee_contract);
        RupeeContract3.changeController(_controller);
        rupee RupeeContract4 = rupee(twenty_Rupee_contract);
        RupeeContract4.changeController(_controller);
        rupee RupeeContract5 = rupee(fifty_Rupee_contract);
        RupeeContract5.changeController(_controller);
        rupee RupeeContract6 = rupee(one_hundred_Rupee_contract);
        RupeeContract6.changeController(_controller);
        rupee RupeeContract7 = rupee(two_hundred_Rupee_contract);
        RupeeContract7.changeController(_controller);
        rupee RupeeContract8 = rupee(five_hundred_Rupee_contract);
        RupeeContract8.changeController(_controller);


    }

}