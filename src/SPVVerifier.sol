// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import { ISPVVerifier } from "./interfaces/ISPVVerifier.sol";
import { IVerifier } from "./interfaces/IVerifier.sol";
import "./library/SparseMerkleProofLib.sol";
import "./interfaces/IMerkleProofVerify.sol";
import "./library/Errors.sol";

contract SPVVerifier is ISPVVerifier {
    error NotOwner();
    error VerifyError();

    mapping(uint256 verifiedBatchNumber => bytes32) public override merkleRoot;
    address public override spvVerifierImpl;
    address public override owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        _;
    }

    function verify(
        uint256[2] calldata _pA,
        uint256[2][2] calldata _pB,
        uint256[2] calldata _pC,
        uint256[37] calldata _pubSignals
    ) external override {
        bytes32 _newRoot = bytes32(
            abi.encodePacked(
                uint64(_pubSignals[3]), uint64(_pubSignals[2]), uint64(_pubSignals[1]), uint64(_pubSignals[0])
            )
        );
        uint256 verifiedBatchNumber = _pubSignals[36];

        uint256[] memory verifiedStateRootPub = new uint256[](32);

        for (uint256 index = 0; index < 32; index++) {
            verifiedStateRootPub[index] = _pubSignals[index + 4];
        }

        bytes memory verifiedStateRoot = abi.encodePacked(verifiedStateRootPub);

        // bool mptSuccess = proof.verify(merkleRoot, leaf);
        bool cirSuccess = IVerifier(spvVerifierImpl).verifyProof(_pA, _pB, _pC, _pubSignals);
        if (!cirSuccess) {
            revert VerifyError();
        }

        syncRoot(verifiedBatchNumber, _newRoot);

        // emit VerifySuccess(msg.sender, leaf);
    }

    function setVerifier(address _verifier) public override onlyOwner {
        spvVerifierImpl = _verifier;
    }

    function syncRoot(uint256 verifiedBatchNumber, bytes32 _newRoot) internal onlyOwner {
        merkleRoot[verifiedBatchNumber] = _newRoot;
    }

    function verifySMT(SparseMerkleProofLib.MerkleProof memory inclusionProof, uint256 verifiedBatchNumber)
        external
        view
        returns (bool)
    {
        return SparseMerkleProofLib.verifyMerkleProof(merkleRoot[verifiedBatchNumber], inclusionProof);
    }
}
