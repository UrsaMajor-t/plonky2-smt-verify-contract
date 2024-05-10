// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import { ISPVVerifier } from "./interfaces/ISPVVerifier.sol";
import { IVerifier } from "./interfaces/IVerifier.sol";
import "./library/SparseMerkleProofLib.sol";
import "./interfaces/IMerkleProofVerify.sol";
import "./interfaces/IPolygonRollupManager.sol";
import "./library/Errors.sol";

contract SPVVerifier is ISPVVerifier {
    error NotOwner();
    error VerifyError();

    mapping(uint256 verifiedBatchNumber => bytes32) public override merkleRoot;
    address public spvVerifierImpl;
    address public override owner;
    address public polygonRollupManager;

    uint32 constant RollupID = 1;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        _;
    }

    function verify(bytes calldata proof) external {
        (uint256[2] memory _pA, uint256[2][2] memory _pB, uint256[2] memory _pC, uint256[37] memory _pubSignals) =
            abi.decode(proof, (uint256[2], uint256[2][2], uint256[2], uint256[37]));

        bytes32 _newRoot = bytes32(
            abi.encodePacked(
                uint64(_pubSignals[3]), uint64(_pubSignals[2]), uint64(_pubSignals[1]), uint64(_pubSignals[0])
            )
        );

        uint64 verifiedBatchNumber = uint64(_pubSignals[36]);

        bytes memory verifiedStateRoot = new bytes(32);
        for (uint256 index = 0; index < 32; index++) {
            verifiedStateRoot[index] = bytes1(uint8(_pubSignals[index + 4]));
        }

        // bool mptSuccess = proof.verify(merkleRoot, leaf);
        bool cirSuccess = IVerifier(spvVerifierImpl).verifyProof(_pA, _pB, _pC, _pubSignals);
        bool batchVerified = verifyBatchInfo(RollupID, verifiedBatchNumber, bytes32(verifiedStateRoot));
        if (!cirSuccess) {
            revert VerifyError();
        }
        if (!batchVerified) {
            revert VerifyError();
        }

        syncRoot(verifiedBatchNumber, _newRoot);

        // emit VerifySuccess(msg.sender, leaf);
    }

    function setVerifier(address _verifier) public override onlyOwner {
        spvVerifierImpl = _verifier;
    }

    function setPolygonRollupManager(address _rollup) external onlyOwner {
        polygonRollupManager = _rollup;
    }

    function syncRoot(uint256 verifiedBatchNumber, bytes32 _newRoot) internal onlyOwner {
        merkleRoot[verifiedBatchNumber] = _newRoot;
    }

    function verifyBatchInfo(uint32 rollupID, uint64 verifiedBatchNumber, bytes32 verifiedStateRoot)
        internal
        view
        onlyOwner
        returns (bool)
    {
        bytes32 _stateRoot =
            IPolygonRollupManager(polygonRollupManager).getRollupBatchNumToStateRoot(rollupID, verifiedBatchNumber);

        return verifiedStateRoot == _stateRoot;
    }

    function verifyLeafInclusionProof(
        SparseMerkleProofLib.MerkleProof memory inclusionProof,
        uint256 verifiedBatchNumber
    ) external view returns (bool) {
        return SparseMerkleProofLib.verifyMerkleProof(merkleRoot[verifiedBatchNumber], inclusionProof);
    }
}
