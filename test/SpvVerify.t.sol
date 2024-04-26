// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "src/SPVVerifier.sol";
import "src/library/Groth16Verifier.sol";
import "src/library/GoldilocksPoseidon.sol";

import "./utils.sol";

contract TestSpv is Utils {
    SPVVerifier spv;
    Groth16Verifier verify;

    function setUp() public {
        verify = new Groth16Verifier();
        spv = new SPVVerifier();
        spv.setVerifier(address(verify));
    }

    function test_verify() public {
        (uint256[2] memory _pA, uint256[2][2] memory _pB, uint256[2] memory _pC, uint256[37] memory _pubSignals) =
            _readHeaderVerifierWitnessFromFile("test/data/verify.json");
        spv.verify(_pA, _pB, _pC, _pubSignals);
    }
}
