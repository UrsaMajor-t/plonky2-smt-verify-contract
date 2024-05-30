// // SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

// import "forge-std/Test.sol";

// import "src/MerkleProofVerify.sol";
// import "src/library/SparseMerkleProof.sol";
// import "src/library/GoldilocksPoseidon.sol";

// contract TestMerkleProofVerify is Test {
//     MerkleProofVerify mpv;

//     function setUp() public {
//         mpv = new MerkleProofVerify();
//         bytes32 newStateRoot = 0x22ee6ab614c8c9cf484420c59fa9cef2bf9a8536095c5c5572ac1b6918c0e705;
//         mpv.updateStateRoot(newStateRoot);
//     }

//     function testVerifyInclusionProof() public view {
//         bytes32[] memory siblings = new bytes32[](2);
//         siblings[0] = 0x71ab6f4175312c78ee0bc776ab91b0e6f86356e7f44807b6856a894231d4d98d;
//         siblings[1] = 0x9e356f158483696de5f958ab07e54c06e9d16f32eba5c9d5895f72a2d8e0dd44;
//         bytes32 value = 0x789f6365f94749dcc6c41d74a7dd3a8ef1b2384715577c73fc52025dbc549e13;
//         SparseMerkleProof.MerkleProof memory merkleProof = SparseMerkleProof.MerkleProof(3, value, siblings);
//         mpv.verifyInclusionProof(merkleProof);
//     }

//     function testHash() public view {
//         bytes32 left = 0x0000000000000000000000000000000000000000000000000000000000000001;
//         bytes32 right = 0x0000000000000000000000000000000000000000000000000000000000000002;
//         bytes32 root = GoldilocksPoseidon.twoToOne(left, right);
//         console.log("root");
//         console.logBytes32(root);
//     }

// }
