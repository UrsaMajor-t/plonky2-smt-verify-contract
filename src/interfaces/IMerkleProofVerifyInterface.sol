// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../library/SparseMerkleProof.sol";

interface IMerkleProofVerifyInterface {
    function verifyInclusionProof(SparseMerkleProof.MerkleProof memory inclusionProof) external view;
}
