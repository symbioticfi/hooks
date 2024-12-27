// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

import {POCBaseTest} from "@symbioticfi/core/test/POCBase.t.sol";
import {Vault} from "@symbioticfi/core/src/contracts/vault/Vault.sol";
import {NetworkRestakeDelegator} from "@symbioticfi/core/src/contracts/delegator/NetworkRestakeDelegator.sol";
import {Slasher} from "@symbioticfi/core/src/contracts/slasher/Slasher.sol";
import {IBaseSlasher} from "@symbioticfi/core/src/interfaces/slasher/IBaseSlasher.sol";
import {ISlasher} from "@symbioticfi/core/src/interfaces/slasher/ISlasher.sol";
import {IBaseDelegator} from "@symbioticfi/core/src/interfaces/delegator/IBaseDelegator.sol";
import {INetworkRestakeDelegator} from "@symbioticfi/core/src/interfaces/delegator/INetworkRestakeDelegator.sol";
import {IVault} from "@symbioticfi/core/src/interfaces/vault/IVault.sol";
import {IVaultConfigurator} from "@symbioticfi/core/src/interfaces/IVaultConfigurator.sol";

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {Subnetwork} from "@symbioticfi/core/src/contracts/libraries/Subnetwork.sol";

import {NetworkRestakeResetHook} from "../../src/contracts/networkRestakeDelegator/NetworkRestakeResetHook.sol";
import {INetworkRestakeResetHook} from "../../src/interfaces/networkRestakeDelegator/INetworkRestakeResetHook.sol";
import {FakeDelegator} from "../mocks/FakeDelegator.sol";

contract NetworkRestakeResetHookTest is POCBaseTest {
    using Math for uint256;
    using Subnetwork for bytes32;
    using Subnetwork for address;

    Vault public vault0;
    NetworkRestakeDelegator public delegator0;
    Slasher public slasher0;

    function setUp() public override {
        SYMBIOTIC_CORE_PROJECT_ROOT = "lib/core/";
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
        AccessControl(address(delegator1)).grantRole(delegator1.OPERATOR_NETWORK_SHARES_SET_ROLE(), hook);
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

    function test_SlashWithHookRevertNotNetworkRestakeDelegator(
        uint256 operatorNetworkShares1
    ) public {
        uint256 depositAmount = 1e18;
        uint256 slashAmount1 = 100;
        operatorNetworkShares1 = bound(operatorNetworkShares1, 1, type(uint256).max / 2);

        uint256 blockTimestamp = block.timestamp * block.timestamp / block.timestamp * block.timestamp / block.timestamp;
        blockTimestamp = blockTimestamp + 1_720_700_948;
        vm.warp(blockTimestamp);

        address hook = address(new NetworkRestakeResetHook(7 days, 3));

        address networkRestakeDelegatorImpl = address(
            new NetworkRestakeDelegator(
                address(networkRegistry),
                address(vaultFactory),
                address(operatorVaultOptInService),
                address(operatorNetworkOptInService),
                address(delegatorFactory),
                delegatorFactory.totalTypes()
            )
        );
        delegatorFactory.whitelist(networkRestakeDelegatorImpl);

        address[] memory networkLimitSetRoleHolders = new address[](1);
        networkLimitSetRoleHolders[0] = alice;
        address[] memory operatorNetworkSharesSetRoleHolders = new address[](1);
        operatorNetworkSharesSetRoleHolders[0] = alice;
        (address vault_, address delegator_, address slasher_) = vaultConfigurator.create(
            IVaultConfigurator.InitParams({
                version: 1,
                owner: alice,
                vaultParams: abi.encode(
                    IVault.InitParams({
                        collateral: address(collateral),
                        burner: address(0xdEaD),
                        epochDuration: 7 days,
                        depositWhitelist: false,
                        isDepositLimit: false,
                        depositLimit: 0,
                        defaultAdminRoleHolder: alice,
                        depositWhitelistSetRoleHolder: alice,
                        depositorWhitelistRoleHolder: alice,
                        isDepositLimitSetRoleHolder: alice,
                        depositLimitSetRoleHolder: alice
                    })
                ),
                delegatorIndex: delegatorFactory.totalTypes() - 1,
                delegatorParams: abi.encode(
                    INetworkRestakeDelegator.InitParams({
                        baseParams: IBaseDelegator.BaseParams({
                            defaultAdminRoleHolder: alice,
                            hook: address(0),
                            hookSetRoleHolder: alice
                        }),
                        networkLimitSetRoleHolders: networkLimitSetRoleHolders,
                        operatorNetworkSharesSetRoleHolders: operatorNetworkSharesSetRoleHolders
                    })
                ),
                withSlasher: true,
                slasherIndex: 0,
                slasherParams: abi.encode(ISlasher.InitParams({baseParams: IBaseSlasher.BaseParams({isBurnerHook: false})}))
            })
        );

        (vault0, delegator0, slasher0) = (Vault(vault_), NetworkRestakeDelegator(delegator_), Slasher(slasher_));

        vm.startPrank(alice);
        delegator0.setHook(hook);
        vm.stopPrank();

        address network = alice;
        _registerNetwork(network, alice);
        _setMaxNetworkLimit(address(delegator0), network, 0, type(uint256).max);

        _registerOperator(alice);

        _optInOperatorVault(vault0, alice);

        _optInOperatorNetwork(alice, address(network));

        _deposit(vault0, alice, depositAmount);

        _setNetworkLimitNetwork(delegator0, alice, network, type(uint256).max);

        _setOperatorNetworkShares(delegator0, alice, network, alice, operatorNetworkShares1);

        blockTimestamp = blockTimestamp + 1;
        vm.warp(blockTimestamp);

        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        blockTimestamp = blockTimestamp + 7 days;
        vm.warp(blockTimestamp);

        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        blockTimestamp = blockTimestamp + 3 days;
        vm.warp(blockTimestamp);

        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        blockTimestamp = blockTimestamp + 5 days;
        vm.warp(blockTimestamp);

        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        blockTimestamp = blockTimestamp + 3 days;
        vm.warp(blockTimestamp);

        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        blockTimestamp = blockTimestamp + 3 days;
        vm.warp(blockTimestamp);

        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator0.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator0.totalOperatorNetworkShares(network.subnetwork(0)), operatorNetworkShares1);
        assertEq(delegator0.operatorNetworkShares(network.subnetwork(0), alice), operatorNetworkShares1);
    }

    function test_SlashWithHookRevertNotVaultDelegator(
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
        AccessControl(address(delegator1)).grantRole(delegator1.OPERATOR_NETWORK_SHARES_SET_ROLE(), hook);
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

        blockTimestamp = blockTimestamp + 1;
        vm.warp(blockTimestamp);

        FakeDelegator fakeDelegator = new FakeDelegator(address(vault1), 0);
        vm.expectRevert(INetworkRestakeResetHook.NotVaultDelegator.selector);
        fakeDelegator.onSlash(hook, network.subnetwork(0), alice, slashAmount1, uint48(blockTimestamp - 1), "");
    }
}
