// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface ISPVVerifier {
    function verify(
        uint256[2] memory _pA,
        uint256[2][2] memory _pB,
        uint256[2] memory _pC,
        uint256[37] memory _pubSignals
    ) external;

    function setVerifier(address _verifier) external;

    function spvVerifierImpl() external view returns (address);

    function merkleRoot(uint256 verifiedBatchNumber) external view returns (bytes32);

    function owner() external view returns (address);

    event VerifySuccess(address indexed verifier, bytes32 proofHash);
}
