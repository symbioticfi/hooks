// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

import {POCBaseTest} from "@symbioticfi/core/test/POCBase.t.sol";

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {Subnetwork} from "@symbioticfi/core/src/contracts/libraries/Subnetwork.sol";

import {NetworkRestakeFairHook} from "../src/contracts/NetworkRestakeFairHook.sol";
import {INetworkRestakeFairHook} from "../src/interfaces/INetworkRestakeFairHook.sol";

contract NetworkRestakeFairHookTest is POCBaseTest {
    using Math for uint256;
    using Subnetwork for bytes32;
    using Subnetwork for address;

    function setUp() public override {
        super.setUp();
    }

    function test_SlashWithHook(
        uint256 depositAmount,
        uint256 operatorNetworkShares1,
        uint256 operatorNetworkShares2,
        uint256 slashAmount1,
        uint256 slashAmount2,
        uint256 networkLimit
    ) public {
        depositAmount = bound(depositAmount, 100, 100 * 10 ** 18);
        operatorNetworkShares1 = bound(operatorNetworkShares1, 1, type(uint256).max / 2);
        operatorNetworkShares2 = bound(operatorNetworkShares2, 1, type(uint256).max / 2);
        slashAmount1 = bound(slashAmount1, 1, type(uint256).max);
        slashAmount2 = bound(slashAmount2, 1, type(uint256).max);
        networkLimit = bound(networkLimit, 1, depositAmount);

        uint256 blockTimestamp = block.timestamp * block.timestamp / block.timestamp * block.timestamp / block.timestamp;
        blockTimestamp = blockTimestamp + 1_720_700_948;
        vm.warp(blockTimestamp);

        address hook = address(new NetworkRestakeFairHook());

        vm.startPrank(alice);
        delegator1.setHook(hook);
        delegator1.grantRole(delegator1.NETWORK_LIMIT_SET_ROLE(), hook);
        delegator1.grantRole(delegator1.OPERATOR_NETWORK_SHARES_SET_ROLE(), hook);
        vm.stopPrank();

        address network = alice;
        _registerNetwork(network, alice);
        _setMaxNetworkLimit(address(delegator1), network, 0, type(uint256).max);

        _registerOperator(alice);
        _registerOperator(bob);

        _optInOperatorVault(vault1, alice);

        _optInOperatorNetwork(alice, address(network));

        _optInOperatorVault(vault1, bob);

        _optInOperatorNetwork(bob, address(network));

        _deposit(vault1, alice, depositAmount);

        _setNetworkLimitNetwork(delegator1, alice, network, networkLimit);

        _setOperatorNetworkShares(delegator1, alice, network, alice, operatorNetworkShares1);
        _setOperatorNetworkShares(delegator1, alice, network, bob, operatorNetworkShares2);

        assertEq(delegator1.networkLimit(network.subnetwork(0)), networkLimit);
        assertEq(
            delegator1.totalOperatorNetworkShares(network.subnetwork(0)),
            operatorNetworkShares1 + operatorNetworkShares2
        );
        assertEq(delegator1.operatorNetworkShares(network.subnetwork(0), alice), operatorNetworkShares1);
        assertEq(delegator1.operatorNetworkShares(network.subnetwork(0), bob), operatorNetworkShares2);

        blockTimestamp = blockTimestamp + 1;
        vm.warp(blockTimestamp);

        uint256 stakeAtAlice = delegator1.stakeAt(network.subnetwork(0), alice, uint48(blockTimestamp - 1), "");
        uint256 stakeAtBob = delegator1.stakeAt(network.subnetwork(0), bob, uint48(blockTimestamp - 1), "");
        vm.assume(stakeAtAlice > slashAmount1);
        uint256 slashedAmount1 = _slash(slasher1, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        uint256 slashedOperatorShares1 = slashedAmount1.mulDiv(operatorNetworkShares1, stakeAtAlice, Math.Rounding.Ceil);

        assertEq(delegator1.networkLimit(network.subnetwork(0)), networkLimit - slashedAmount1);
        assertEq(
            delegator1.totalOperatorNetworkShares(network.subnetwork(0)),
            operatorNetworkShares1 + operatorNetworkShares2 - slashedOperatorShares1
        );
        assertEq(
            delegator1.operatorNetworkShares(network.subnetwork(0), alice),
            operatorNetworkShares1 - slashedOperatorShares1
        );
        assertEq(delegator1.operatorNetworkShares(network.subnetwork(0), bob), operatorNetworkShares2);
        assertLe(stakeAtBob, delegator1.stakeAt(network.subnetwork(0), bob, uint48(blockTimestamp), ""));

        uint256 slashedAmount2 = _slash(slasher1, alice, network, alice, slashAmount2, uint48(blockTimestamp - 1), "");

        uint256 slashedOperatorShares2 = slashedAmount2.mulDiv(operatorNetworkShares1, stakeAtAlice, Math.Rounding.Ceil);

        assertEq(delegator1.networkLimit(network.subnetwork(0)), networkLimit - slashedAmount1 - slashedAmount2);
        assertApproxEqAbs(
            delegator1.totalOperatorNetworkShares(network.subnetwork(0)),
            operatorNetworkShares1 + operatorNetworkShares2 - slashedOperatorShares1 - slashedOperatorShares2,
            1
        );
        assertApproxEqAbs(
            delegator1.operatorNetworkShares(network.subnetwork(0), alice),
            operatorNetworkShares1 - slashedOperatorShares1
                - Math.min(operatorNetworkShares1 - slashedOperatorShares1, slashedOperatorShares2),
            1
        );
        assertEq(delegator1.operatorNetworkShares(network.subnetwork(0), bob), operatorNetworkShares2);
        assertLe(stakeAtBob, delegator1.stakeAt(network.subnetwork(0), bob, uint48(blockTimestamp), ""));
    }
}
