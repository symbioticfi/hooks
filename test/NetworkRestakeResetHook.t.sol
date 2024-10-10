// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

import {POCBaseTest} from "@symbioticfi/core/test/POCBase.t.sol";

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {Subnetwork} from "@symbioticfi/core/src/contracts/libraries/Subnetwork.sol";

import {NetworkRestakeResetHook} from "../src/contracts/NetworkRestakeResetHook.sol";
import {INetworkRestakeResetHook} from "../src/interfaces/INetworkRestakeResetHook.sol";

contract NetworkRestakeResetHookTest is POCBaseTest {
    using Math for uint256;
    using Subnetwork for bytes32;
    using Subnetwork for address;

    function setUp() public override {
        super.setUp();
    }

    function test_SlashWithHook(
        uint256 operatorNetworkShares1
    ) public {
        uint256 depositAmount = 1e18;
        uint256 slashAmount1 = 100;
        operatorNetworkShares1 = bound(operatorNetworkShares1, 1, type(uint256).max / 2);

        uint256 blockTimestamp = block.timestamp * block.timestamp / block.timestamp * block.timestamp / block.timestamp;
        blockTimestamp = blockTimestamp + 1_720_700_948;
        vm.warp(blockTimestamp);

        address hook = address(new NetworkRestakeResetHook(7 days, 3));

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

        _slash(slasher1, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator1.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator1.totalOperatorNetworkShares(network.subnetwork(0)), operatorNetworkShares1);
        assertEq(delegator1.operatorNetworkShares(network.subnetwork(0), alice), operatorNetworkShares1);

        blockTimestamp = blockTimestamp + 7 days;
        vm.warp(blockTimestamp);

        _slash(slasher1, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator1.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator1.totalOperatorNetworkShares(network.subnetwork(0)), operatorNetworkShares1);
        assertEq(delegator1.operatorNetworkShares(network.subnetwork(0), alice), operatorNetworkShares1);

        blockTimestamp = blockTimestamp + 3 days;
        vm.warp(blockTimestamp);

        _slash(slasher1, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator1.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator1.totalOperatorNetworkShares(network.subnetwork(0)), operatorNetworkShares1);
        assertEq(delegator1.operatorNetworkShares(network.subnetwork(0), alice), operatorNetworkShares1);

        blockTimestamp = blockTimestamp + 5 days;
        vm.warp(blockTimestamp);

        _slash(slasher1, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator1.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator1.totalOperatorNetworkShares(network.subnetwork(0)), operatorNetworkShares1);
        assertEq(delegator1.operatorNetworkShares(network.subnetwork(0), alice), operatorNetworkShares1);

        blockTimestamp = blockTimestamp + 3 days;
        vm.warp(blockTimestamp);

        _slash(slasher1, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator1.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator1.totalOperatorNetworkShares(network.subnetwork(0)), operatorNetworkShares1);
        assertEq(delegator1.operatorNetworkShares(network.subnetwork(0), alice), operatorNetworkShares1);

        blockTimestamp = blockTimestamp + 3 days;
        vm.warp(blockTimestamp);

        _slash(slasher1, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator1.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator1.totalOperatorNetworkShares(network.subnetwork(0)), 0);
        assertEq(delegator1.operatorNetworkShares(network.subnetwork(0), alice), 0);
    }
}
