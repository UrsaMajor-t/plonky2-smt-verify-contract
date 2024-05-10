// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "src/SPVVerifier.sol";
import "src/library/Groth16Verifier.sol";
import "src/library/GoldilocksPoseidon.sol";

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
        vm.rollFork(5_780_170);
        vm.prank(address(0x596444771ED471004B6780d244cE17F26dB2beCc));
        address spv_address = address(0xaB8336f983BFfbe56CBBeB6dDE893224A66EA154);
        bytes memory proof = _readEncodeCalldataFromFile("test/data/verify.json");
        SPVVerifier(spv_address).verify(proof);
    }

    function test_verify_mock() public {
        bytes memory proof = _readEncodeCalldataFromFile("test/data/verify.json");
        spv.verify(proof);
    }

    function test_verify_batch_info_fork_sepolia() public {
        // vm.selectFork(sepoliaFork);
        // vm.rollFork(5_781_090);
        address rollup = address(0x32d33D5137a7cFFb54c5Bf8371172bcEc5f310ff);
        spv.setPolygonRollupManager(rollup);
        // bytes32 stateRoot = hex"1dd7c042ef64b115312d6b6237ad4b51e2ba48fe3d9155624c7b0fbd6141c688";
        // spv.verifyBatchInfoTest(1, 76_920, stateRoot);
    }
}
