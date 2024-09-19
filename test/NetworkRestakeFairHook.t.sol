// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

import {POCBaseTest} from "@symbioticfi/core/test/POCBase.t.sol";

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {Subnetwork} from "@symbioticfi/core/src/contracts/libraries/Subnetwork.sol";

import {NetworkRestakeFairHook} from "../src/contracts/NetworkRestakeFairHook.sol";

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
        uint256 slashAmount1,
        uint256 slashAmount2
    ) public {
        depositAmount = bound(depositAmount, 1, 100 * 10 ** 18);
        operatorNetworkShares1 = bound(operatorNetworkShares1, 1, type(uint256).max / 2);
        slashAmount1 = bound(slashAmount1, 1, type(uint256).max);
        slashAmount2 = bound(slashAmount2, 1, type(uint256).max);
        vm.assume(slashAmount1 < Math.min(depositAmount, Math.min(type(uint256).max, operatorNetworkShares1)));

        uint256 blockTimestamp = block.timestamp * block.timestamp / block.timestamp * block.timestamp / block.timestamp;
        blockTimestamp = blockTimestamp + 1_720_700_948;
        vm.warp(blockTimestamp);

        address hook = address(new NetworkRestakeFairHook());

        vm.startPrank(alice);
        delegator1.setHook(hook);
        delegator1.grantRole(delegator1.OPERATOR_NETWORK_SHARES_SET_ROLE(), hook);
        vm.stopPrank();

        address network = alice;
        _registerNetwork(network, alice);
        _setMaxNetworkLimit(address(delegator1), network, 0, type(uint256).max);

        _registerOperator(alice);

        _optInOperatorVault(vault1, alice);

        _optInOperatorNetwork(alice, address(network));

        _deposit(vault1, alice, depositAmount);

        _setNetworkLimitNetwork(delegator1, alice, network, type(uint256).max);

        _setOperatorNetworkShares(delegator1, alice, network, alice, operatorNetworkShares1);

        assertEq(delegator1.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator1.totalOperatorNetworkShares(network.subnetwork(0)), operatorNetworkShares1);
        assertEq(delegator1.operatorNetworkShares(network.subnetwork(0), alice), operatorNetworkShares1);

        blockTimestamp = blockTimestamp + 1;
        vm.warp(blockTimestamp);

        uint256 slashableStake = slasher1.slashableStake(network.subnetwork(0), alice, uint48(blockTimestamp - 1), "");
        uint256 slashedAmount = _slash(slasher1, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        uint256 operatorShares =
            operatorNetworkShares1 - slashedAmount.mulDiv(operatorNetworkShares1, slashableStake, Math.Rounding.Ceil);

        assertEq(delegator1.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator1.totalOperatorNetworkShares(network.subnetwork(0)), operatorShares);
        assertEq(delegator1.operatorNetworkShares(network.subnetwork(0), alice), operatorShares);

        slashableStake = slasher1.slashableStake(network.subnetwork(0), alice, uint48(blockTimestamp - 1), "");
        slashedAmount = _slash(slasher1, alice, network, alice, slashAmount2, uint48(blockTimestamp - 1), "");

        operatorShares = operatorShares - slashedAmount.mulDiv(operatorShares, slashableStake, Math.Rounding.Ceil);

        assertEq(delegator1.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator1.totalOperatorNetworkShares(network.subnetwork(0)), operatorShares);
        assertEq(delegator1.operatorNetworkShares(network.subnetwork(0), alice), operatorShares);
    }
}
