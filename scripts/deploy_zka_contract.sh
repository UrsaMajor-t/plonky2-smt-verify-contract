#!/bin/bash
source .env

# To deploy and verify our contract
forge script scripts/zka_deploy.s.sol:ZkADeploy --rpc-url $POLYGON_CARDONA_RPC_URL \
--broadcast \
--legacy \
-vvvv
