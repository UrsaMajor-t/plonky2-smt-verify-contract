#!/bin/bash
source .env

forge create --rpc-url $SEPOLIA_RPC_URL \
--private-key $PRIVATE_KEY \
--etherscan-api-key $ETHERSCAN_API \
--verify \
src/SPVVerifier.sol:SPVVerifier 

