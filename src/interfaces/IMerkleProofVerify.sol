// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../library/SparseMerkleProofLib.sol";

interface IMerkleProofVerifyInterface {
    function verifyInclusionProof(SparseMerkleProofLib.MerkleProof memory inclusionProof) external view;
}
