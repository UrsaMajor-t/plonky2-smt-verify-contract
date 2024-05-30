// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../lib/YulDeployer.sol";
import { SPVProofMock, SPVParse } from "../src/SPVProofMock.sol";

contract ParseProof is Test {
    YulDeployer yulDeployer;
    SPVProofMock spv;
    bytes proof;

    function setUp() public {
        // yulDeployer = new YulDeployer();
        // address verify = address(yulDeployer.deployContract("verify"));
        // vm.makePersistent(verify);
        spv = SPVProofMock(address(0x0));

        // this is a valid SNARK proof for AxiomV1Query, where some of the blocks in the query are within the last ~1024 blocks
        proof = vm.parseBytes(vm.readFile("test/data/verify.calldata"));
    }

    function test_verifyProof() public {
        SPVParse spvParse = new SPVParse();
        spvParse.parse(proof);
        // spv.verifyProof(proof);
    }
}
