// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./GoldilocksPoseidon.sol";

library SparseMerkleProof {
    struct MerkleProof {
        uint256 index;
        bytes32 value;
        bytes32[] siblings;
    }

    // Compure Merkle root.
    function _computeMerkleRoot(MerkleProof memory proof) internal pure returns (bytes32) {
        bytes32 computedHash = proof.value;
        uint256 index = proof.index;

        for (uint256 i = 0; i < proof.siblings.length; i++) {
            uint256 branchIndex = index & 1;
            index = index >> 1;

            if (branchIndex == 1) {
                computedHash = GoldilocksPoseidon.twoToOne(proof.siblings[i], computedHash);
            } else {
                computedHash = GoldilocksPoseidon.twoToOne(computedHash, proof.siblings[i]);
            }
        }

        return computedHash;
    }

    // Compure Merkle root in the case that the proof index has reverse bit order.
    function _computeMerkleRootRbo(MerkleProof memory proof) internal pure returns (bytes32) {
        bytes32 computedHash = proof.value;
        uint256 index = proof.index << (256 - proof.siblings.length);

        for (uint256 i = proof.siblings.length; i != 0; i--) {
            uint256 branchIndex = (index >> 255) & 1;
            index = index << 1;

            if (branchIndex == 1) {
                computedHash = GoldilocksPoseidon.twoToOne(proof.siblings[i - 1], computedHash);
            } else {
                computedHash = GoldilocksPoseidon.twoToOne(computedHash, proof.siblings[i - 1]);
            }
        }

        return computedHash;
    }
}
