// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.23;

import "forge-std/Test.sol";

import "src/MerkleProofVerify.sol";
import "src/library/SparseMerkleProof.sol";
import "src/library/GoldilocksPoseidon.sol";

contract TestMerkleProofVerify is Test {
    MerkleProofVerify mpv;

    function setUp() public {
        mpv = new MerkleProofVerify();
        bytes32 newStateRoot = 0xed4d6370d52b7fe6bac733b87552308976c80d1bb1e0d1ddebd8cce5a1a9756e;
        mpv.updateStateRoot(newStateRoot);
    }

    function testVerifyInclusionProof() public view {
        bytes32[] memory siblings = new bytes32[](3);
        siblings[2] = 0x987c2fe2acea5e9b02f350667b070def7c505177f84ab1b989bfed34f4ed8692;
        siblings[1] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        siblings[0] = 0x71ab6f4175312c78ee0bc776ab91b0e6f86356e7f44807b6856a894231d4d98d;
        bytes32 value = 0xd0560b0c0313a71c09854daf25b80e455a05bf0e01edb23503acb9b174e04c2b;
        SparseMerkleProof.MerkleProof memory merkleProof = SparseMerkleProof.MerkleProof(5, value, siblings);
        mpv.verifyInclusionProof(merkleProof);
    }

    function testHash() public view {
        bytes32 left = 0x0000000000000000000000000000000000000000000000000000000000000001;
        bytes32 right = 0x0000000000000000000000000000000000000000000000000000000000000002;
        bytes32 root = GoldilocksPoseidon.twoToOne(left, right);
        console.log("root");
        console.logBytes32(root);
    }
}
