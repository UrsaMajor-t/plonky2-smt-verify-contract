// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "src/SPVVerifier.sol";
import "src/library/Groth16Verifier.sol";
import "src/library/GoldilocksPoseidon.sol";
import "src/library/SparseMerkleProofLib.sol";

import "./utils.sol";

contract TestSpv is Utils {
    uint256 sepoliaFork;
    SPVVerifier spv;
    Groth16Verifier verify;

    function setUp() public {
        string memory SEPOLIA_RPC_URL = vm.envString("SEPOLIA_RPC_URL");
        sepoliaFork = vm.createFork(SEPOLIA_RPC_URL);

        verify = new Groth16Verifier();
        spv = new SPVVerifier();
        spv.setVerifier(address(verify));
    }

    function test_verify_fork_sepolia() public {
        vm.selectFork(sepoliaFork);
        vm.rollFork(5_899_056);
        vm.prank(address(0xa54753229AD35abC403B53E629A28820C8041eaA));
        address spv_address = address(0x668C6F178D11d9B794757862c239b865E79c2F3A);
        bytes memory proof = _readEncodeCalldataFromFile("test/data/verify.json");
        SPVVerifier(spv_address).verify(proof);
    }

    function test_verify_mock() public {
        bytes memory proof = _readEncodeCalldataFromFile("test/data/verify.json");
        spv.verify(proof);
    }

    function test_verify_leaf_inclusion_proof_fork_sepolia() public {
        vm.selectFork(sepoliaFork);
        vm.rollFork(5_899_056);
        vm.prank(address(0xa54753229AD35abC403B53E629A28820C8041eaA));
        address spv_address = address(0x668C6F178D11d9B794757862c239b865E79c2F3A);
        bytes32[] memory siblings = new bytes32[](2);
        siblings[0] = 0xea927c8b9bf6e0e9fad1ff39ff2c3cac626c8eb5ffc2d0efd7b6864dabfce25b;
        siblings[1] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        bytes32 value = 0x55d7b8113058bd2f6968b658a96f59e42695fea1cfc9adc34bf4bbd58570da59;
        SparseMerkleProofLib.MerkleProof memory merkleProof = SparseMerkleProofLib.MerkleProof(9, value, siblings);
        bool success = SPVVerifier(spv_address).verifyLeafInclusionProof(merkleProof, 79_542);
        console.log("success %s", success);
    }

    function test_verify_leaf_inclusion_proof_mock() public view {
        bytes32[] memory siblings = new bytes32[](2);
        siblings[0] = 0xea927c8b9bf6e0e9fad1ff39ff2c3cac626c8eb5ffc2d0efd7b6864dabfce25b;
        siblings[1] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        bytes32 value = 0x55d7b8113058bd2f6968b658a96f59e42695fea1cfc9adc34bf4bbd58570da59;
        bytes32 root = 0x170710439eab73dd579f2183a3ea65edc6edce7ced51783d9d02ad92d49a6b55;
        SparseMerkleProofLib.MerkleProof memory merkleProof = SparseMerkleProofLib.MerkleProof(9, value, siblings);
        bytes32 root1 = spv.verifyLeafInclusionProofTest(merkleProof);
        console.log("root");
        console.logBytes32(root1);
    }
}
