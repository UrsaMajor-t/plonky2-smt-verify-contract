// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IPolygonRollupManager {
    function getRollupBatchNumToStateRoot(uint32 rollupID, uint64 batchNum) external view returns (bytes32);
}
