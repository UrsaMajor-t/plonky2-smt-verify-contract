// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface ISPVVerifier {
    function verify(bytes calldata proof) external;

    function setVerifier(address _verifier) external;

    function merkleRoot(uint256 verifiedBatchNumber) external view returns (bytes32);

    function owner() external view returns (address);

    event VerifySuccess(address indexed verifier, bytes32 proofHash);
}
