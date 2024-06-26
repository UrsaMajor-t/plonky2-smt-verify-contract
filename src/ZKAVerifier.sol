// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import { IZKAVerifier } from "./interfaces/IZKAVerifier.sol";
import { IZKAFactory } from "./interfaces/IZKAFactory.sol";

contract ZKAVerifier is IZKAVerifier {
    error AlreadyInitialized();
    error VerifyFail();

    address public override ZKAFactory;
    address public override ZKVerifier;

    constructor() payable { }

    function initializer(address _ZKAFactory, address _ZKVerifier) external {
        if (ZKAFactory != address(0) || ZKVerifier != address(0)) {
            revert AlreadyInitialized();
        }
        ZKAFactory = _ZKAFactory;
        ZKVerifier = _ZKVerifier;
    }

    function zkpVerify(bytes calldata zkProof) external override {
        (bool success,) = ZKVerifier.call{ gas: 600_000 }(zkProof);
        if (success != true) {
            revert VerifyFail();
        }
        IZKAFactory(ZKAFactory).proofToStorage(fetchProofKey(zkProof, ZKVerifier), msg.sender);
    }

    function fetchProofKey(bytes calldata proof, address verifyContract) public view returns (bytes32) {
        return keccak256(abi.encode(proof, verifyContract, msg.sender, IZKAFactory(ZKAFactory).userNonce(msg.sender)));
    }
}
