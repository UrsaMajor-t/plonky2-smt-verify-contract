#!/bin/bash

source .env

forge create --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY src/library/Groth16Verifier.sol:Groth16Verifier