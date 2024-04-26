// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.23;

import "forge-std/console.sol";
import "forge-std/Test.sol";
import "forge-std/StdJson.sol";

contract Utils is Test {
    using stdJson for string;

    function _readHeaderVerifierWitnessFromFile(string memory filename)
        internal
        returns (uint256[2] memory _pA, uint256[2][2] memory _pB, uint256[2] memory _pC, uint256[37] memory pubSignals)
    {
        string memory file = vm.readFile(filename);
        bytes memory _calldata = file.readBytes(".calldata");

        (_pA, _pB, _pC, pubSignals) = abi.decode(_calldata, (uint256[2], uint256[2][2], uint256[2], uint256[37]));
    }

    function _readEncodeCalldataFromFile(string memory filename) internal returns (bytes memory _calldata) {
        string memory file = vm.readFile(filename);
        _calldata = file.readBytes(".calldata");
    }
}
