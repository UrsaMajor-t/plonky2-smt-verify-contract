// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../library/SparseMerkleProofLib.sol";

interface IMerkleProofVerify {
    function verifyInclusionProof(SparseMerkleProofLib.MerkleProof memory inclusionProof) external view;
}
