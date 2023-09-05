// SPDX-License-Identifier: MIT
// buy Erupee v1.3
pragma solidity ^0.8.16;

interface IMyToken {
    function safeMint(address to) external;

    function transfer_rupee(address _from, address _to) external;

    function return_num_notes(address _user) external returns (uint256);

    function burn_nft(address _address) external;
}

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract buy_ERupee {
    address immutable _owner;
    address public rupee_contract_ERC20;
    address[9] public _rupeeContractList;
    uint256 public _num;
    bytes32 public rootHash;
    mapping(address => uint256) public userFundsMapping;
    mapping(address => bool) public isBlackListedMapping;
    uint256[] denominationArr = [500, 200, 100, 50, 20, 10, 5, 2, 1];

    constructor() {
        _owner = msg.sender;
    }

    modifier checkValidAddress(bytes32[] calldata proof, address _addr) {
        require(
            MerkleProof.verify(
                proof,
                rootHash,
                keccak256(abi.encodePacked(_addr))
            ) == true,
            "transfer to non valid address"
        );
        _;
    }

    modifier onlyOwner() {
        require(_owner == msg.sender, "can only be called by owner");
        _;
    }

    modifier blackListedCheck(address _to) {
        require(
            isBlackListedMapping[_to] == false,
            "reciever's address is blacklisted"
        );
        _;
    }

    function setContracts(
        address _1Rupee,
        address _2Rupee,
        address _5Rupee,
        address _10Rupee,
        address _20Rupee,
        address _50Rupee,
        address _100Rupee,
        address _200Rupee,
        address _500Rupee,
        address _rupeeContract_ERC20
    ) external onlyOwner returns (bool) {
        rupee_contract_ERC20 = _rupeeContract_ERC20;
        _rupeeContractList = [
            _500Rupee,
            _200Rupee,
            _100Rupee,
            _50Rupee,
            _20Rupee,
            _10Rupee,
            _5Rupee,
            _2Rupee,
            _1Rupee
        ];
        return true;
    }

    function setRootHash(bytes32 _hash) external onlyOwner returns (bool) {
        rootHash = _hash;
        return true;
    }

    function getUserFundAmt(address _user) public view returns (uint256) {
        return userFundsMapping[_user];
    }

    function blackList(address _blackListAddr) public onlyOwner {
        isBlackListedMapping[_blackListAddr] = true;
    }

    function noteCalculation(
        uint256 _num1,
        uint256 _division
    ) public returns (uint256, uint256) {
        uint256 _RupeeNum = _num1 / _division;
        _num = _num1 % _division;
        return (_RupeeNum, _num);
    }

    function buy_With_note_denominations(uint256 _amount) external {
        uint256[9] memory userNoteCount;
        IERC20 _rupeeContract = IERC20(rupee_contract_ERC20);
        _rupeeContract.transferFrom(msg.sender, address(this), _amount);
        uint256 _num1 = _amount / (10 ** 18);

        for (uint256 k = 0; k < 9; k++) {
            uint256 temp = 0;
            (temp, _num1) = (noteCalculation(_num1, denominationArr[k]));
            userNoteCount[k] = temp;
        }

        uint256 i = 0;
        for (i = 0; i < 9; i++) {
            for (uint256 j = 0; j < userNoteCount[i]; j++) {
                IMyToken __Rupee_contract = IMyToken(_rupeeContractList[i]);
                __Rupee_contract.safeMint(msg.sender);
            }
        }
        userFundsMapping[msg.sender] += _amount;
    }

    function fetchUserNotes(
        address _user
    ) internal returns (uint256[9] memory) {
        uint256[9] memory _availArr;
        for (uint256 i = 0; i < 9; ++i) {
            IMyToken __Rupee_contract = IMyToken(_rupeeContractList[i]);
            _availArr[i] = __Rupee_contract.return_num_notes(_user);
        }
        return _availArr;
    }

    function transferAmount(
        uint256 _amount,
        address _to,
        bytes32[] calldata proof
    ) public blackListedCheck(_to) checkValidAddress(proof, _to) {
        _transferAmount(_amount, _to);
    }

    function _transferAmount(uint256 _amount, address _to) internal {
        //uint256[] public availArr = [5, 0, 0, 0, 0, 0, 0, 0, 0];
        //uint256[] public neededArr = [4, 0, 1, 1, 0, 0, 0, 1, 0];
        //uint256[] public denominationsNotes = [500, 200, 100, 50, 20, 10, 5, 2, 1];
        //uint256[] public transferArr = [0, 0, 0, 0, 0, 0, 0, 0, 0];
        //uint256 public rem_mint = 0;
        require(
            userFundsMapping[msg.sender] >= _amount,
            "funds are less than requested"
        );
        uint256[9] memory NoteAvailArr = fetchUserNotes(msg.sender); // current note count
        uint256[9] memory NoteNeededCount; // exact amt needed for transaction
        uint256[9] memory transferArr; // transfer to user at last
        userFundsMapping[msg.sender] -= _amount;
        userFundsMapping[_to] += _amount;
        uint256 _num1 = _amount / (10 ** 18);
        uint256 rem_mint = 0;
        uint256 rem_change = 0;
        uint256 denom_burn;

        for (uint256 k = 0; k < 9; ++k) {
            uint256 temp = 0;
            (temp, _num1) = (noteCalculation(_num1, denominationArr[k]));
            NoteNeededCount[k] = (temp);
        }
        uint256 total = 0;

        for (uint256 i = 0; i < 9; ++i) {
            if (NoteAvailArr[i] >= NoteNeededCount[i]) {
                total += denominationArr[i] * NoteNeededCount[i];
                transferArr[i] = NoteNeededCount[i];
                NoteAvailArr[i] -= NoteNeededCount[i];
            } else {
                uint256 change = _amount / (10 ** 18) - total;
                for (uint256 j = i - 1; j >= 0; j--) {
                    if (change < denominationArr[j] && NoteAvailArr[j] > 0) {
                        rem_mint = denominationArr[j] - change;
                        rem_change = denominationArr[j] - rem_mint;
                        denom_burn = denominationArr[j];
                        IMyToken __Rupee_contract = IMyToken(
                            _rupeeContractList[j]
                        );
                        __Rupee_contract.transfer_rupee(msg.sender, address(0));
                        break;
                    }
                }
                break;
            }
        }
        // send denom_burn from sender's wallet to 0 address-done
        // send transferArr's content to reciever's address- done
        // mint notes of rem_mint and send to sender- done
        // mint notes of rem_change and send to reciever- done
        sendNFT(transferArr, _to, rem_mint, rem_change);
    }

    function sendNFT(
        uint256[9] memory _transferArr,
        address _to,
        uint256 _rem_mint,
        uint256 _rem_change
    ) internal {
        for (uint256 i = 0; i < 9; ++i) {
            for (uint256 j = 0; j < _transferArr[i]; ++j) {
                IMyToken __Rupee_contract = IMyToken(_rupeeContractList[i]);
                __Rupee_contract.transfer_rupee(msg.sender, _to);
            }
        }

        uint256 _num1 = _rem_mint;
        uint256 _num2 = _rem_change;
        uint256[9] memory NoteNeeded_rem_mint;
        uint256[9] memory NoteNeeded_rem_change;

        for (uint256 k = 0; k < 9; ++k) {
            uint256 temp = 0;
            (temp, _num1) = (noteCalculation(_num1, denominationArr[k]));
            NoteNeeded_rem_mint[k] = temp;
        }

        for (uint256 i = 0; i < 9; ++i) {
            for (uint256 j = 0; j < NoteNeeded_rem_mint[i]; ++j) {
                IMyToken __Rupee_contract = IMyToken(_rupeeContractList[i]);
                __Rupee_contract.safeMint(msg.sender);
            }
        }

        for (uint256 k = 0; k < 9; k++) {
            uint256 temp = 0;
            (temp, _num2) = (noteCalculation(_num2, denominationArr[k]));
            NoteNeeded_rem_change[k] = temp;
        }

        for (uint256 i = 0; i < 9; i++) {
            for (uint256 j = 0; j < NoteNeeded_rem_change[i]; j++) {
                IMyToken __Rupee_contract = IMyToken(_rupeeContractList[i]);
                __Rupee_contract.safeMint(_to);
            }
        }
    }
}
