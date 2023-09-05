// SPDX-License-Identifier: UNLICENSED
 pragma solidity 0.8.18;
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleTreeWhiteListChecker {
    bytes32 public rootHash;
    uint256 public count;
    address public admin;

    modifier onlyowner() {
        require(msg.sender == admin, "admin can call the function");
    }
    
    constructor(){
        admin = msg.sender;
    }

    function setRootHash(bytes32 _hash) external onlyowner returns(bool) {
        rootHash = _hash;
    }

    function setAdmin(address _admin) external onlyowner returns(bool) {
        _admin = admin;
        return true;
    }

    modifier isWhiteListedAddress(bytes32[] calldata proof){
       require(isValidProof(proof,keccak256(abi.encodePacked(msg.sender))),"Not WhiteListed Address");
        _;
    }

    function isValidProof(bytes32[] calldata proof, bytes32 leaf)  external view returns (bool) {
        return MerkleProof.verify(proof, rootHash, leaf);
    }

}