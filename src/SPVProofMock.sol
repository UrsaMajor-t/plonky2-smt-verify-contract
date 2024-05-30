// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/console.sol";

contract SPVProofMock {
    address private verify;

    constructor(address _verify) {
        setVerify(_verify);
    }

    function setVerify(address _verify) public {
        verify = _verify;
    }

    function verifyProof(bytes calldata proof) external {
        (bool success,) = verify.call(proof);
        if (!success) {
            revert("Proof verification failed");
        }
    }
}

contract SPVParse {
    uint256 ProofLength = 384;
    uint256 SplitStep = 32;
    uint256 TransactionSplitStart = ProofLength; // 384 is proof length
    uint256 TrackBlockSplitStart = TransactionSplitStart + SplitStep * 7;

    constructor() { }

    function parse(bytes calldata proof) public view {
        bytes32 originalBlockHash = bytes32(
            uint256(bytes32(proof[TransactionSplitStart:TransactionSplitStart + SplitStep])) << 128
                | uint256(bytes32(proof[TransactionSplitStart + SplitStep:TransactionSplitStart + SplitStep * 2]))
        );
        console.log("originalBlockHash");
        console.logBytes32(originalBlockHash);

        bytes32 txHash = bytes32(
            uint256(bytes32(proof[TransactionSplitStart + SplitStep * 2:TransactionSplitStart + SplitStep * 3])) << 128
                | uint256(bytes32(proof[TransactionSplitStart + SplitStep * 3:TransactionSplitStart + SplitStep * 4]))
        );
        console.log("txHash");
        console.logBytes32(txHash);

        uint256 receipt_status =
            uint256(bytes32(proof[TransactionSplitStart + SplitStep * 4:TransactionSplitStart + SplitStep * 5]));
        console.log("receipt_status %s", receipt_status);

        bytes32 commitBlockHash = bytes32(
            uint256(bytes32(proof[TransactionSplitStart + SplitStep * 5:TransactionSplitStart + SplitStep * 6])) << 128
                | uint256(bytes32(proof[TransactionSplitStart + SplitStep * 6:TransactionSplitStart + SplitStep * 7]))
        );
        console.log("commitBlockHash");
        console.logBytes32(commitBlockHash);

        bytes32 batch_blocks_merkle_root = bytes32(
            uint256(bytes32(proof[TransactionSplitStart + SplitStep * 8:TransactionSplitStart + SplitStep * 9])) << 128
                | uint256(bytes32(proof[TransactionSplitStart + SplitStep * 9:TransactionSplitStart + SplitStep * 10]))
        );
        console.log("batch_blocks_merkle_root");
        console.logBytes32(batch_blocks_merkle_root);

        bytes32 batch_blocks_target_block_hash = bytes32(
            uint256(bytes32(proof[TransactionSplitStart + SplitStep * 10:TransactionSplitStart + SplitStep * 11]))
                << 128
                | uint256(bytes32(proof[TransactionSplitStart + SplitStep * 11:TransactionSplitStart + SplitStep * 12]))
        );
        console.log("batch_blocks_target_block_hash");
        console.logBytes32(batch_blocks_target_block_hash);
    }
}
