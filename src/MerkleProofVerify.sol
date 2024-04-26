// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "./library/SparseMerkleProofLib.sol";
import "./interfaces/IMerkleProofVerify.sol";
import "./library/Errors.sol";

contract MerkleProofVerify is IMerkleProofVerify {
    bytes32 public stateRoot;

    function updateStateRoot(bytes32 newStateRoot) external {
        stateRoot = newStateRoot;
    }

    function verifyInclusionProof(SparseMerkleProof.MerkleProof memory inclusionProof) external view {
        bool verified = SparseMerkleProof.verifyMerkleProof(stateRoot, inclusionProof);
        if (!verified) {
            revert InvalidMerkleRoot();
        }
    }
}
