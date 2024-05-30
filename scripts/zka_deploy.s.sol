// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/ZKAVerifier.sol";
import "../src/ZKAFactory.sol";

contract ZkADeploy is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("DEPLOY");
        vm.startBroadcast(deployerPrivateKey);

        ZKAVerifier verifier = new ZKAVerifier();

        console.log("verifier address: %s", address(verifier));

        ZKAFactory factory = new ZKAFactory();

        console.log("factory address: %s", address(factory));

        factory.setimplZKAVerifier(address(verifier));

        vm.stopBroadcast();
    }
}
