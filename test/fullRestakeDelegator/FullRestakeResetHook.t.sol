// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

import {POCBaseTest} from "@symbioticfi/core/test/POCBase.t.sol";
import {Vault} from "@symbioticfi/core/src/contracts/vault/Vault.sol";
import {FullRestakeDelegator} from "@symbioticfi/core/src/contracts/delegator/FullRestakeDelegator.sol";
import {Slasher} from "@symbioticfi/core/src/contracts/slasher/Slasher.sol";
import {IBaseSlasher} from "@symbioticfi/core/src/interfaces/slasher/IBaseSlasher.sol";
import {ISlasher} from "@symbioticfi/core/src/interfaces/slasher/ISlasher.sol";
import {IBaseDelegator} from "@symbioticfi/core/src/interfaces/delegator/IBaseDelegator.sol";
import {IFullRestakeDelegator} from "@symbioticfi/core/src/interfaces/delegator/IFullRestakeDelegator.sol";
import {IVault} from "@symbioticfi/core/src/interfaces/vault/IVault.sol";
import {IVaultConfigurator} from "@symbioticfi/core/src/interfaces/IVaultConfigurator.sol";

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {Subnetwork} from "@symbioticfi/core/src/contracts/libraries/Subnetwork.sol";

import {FullRestakeResetHook} from "../../src/contracts/fullRestakeDelegator/FullRestakeResetHook.sol";
import {IFullRestakeResetHook} from "../../src/interfaces/fullRestakeDelegator/IFullRestakeResetHook.sol";
import {FakeDelegator} from "../mocks/FakeDelegator.sol";

contract FullRestakeResetHookTest is POCBaseTest {
    using Math for uint256;
    using Subnetwork for bytes32;
    using Subnetwork for address;

    Vault public vault0;
    FullRestakeDelegator public delegator0;
    Slasher public slasher0;

    function setUp() public override {
        SYMBIOTIC_CORE_PROJECT_ROOT = "lib/core/";

        super.setUp();
    }

    function test_SlashWithHook(
        uint256 operatorNetworkLimit1
    ) public {
        uint256 depositAmount = 1e18;
        uint256 slashAmount1 = 100;
        operatorNetworkLimit1 = bound(operatorNetworkLimit1, 1, type(uint256).max / 2);

        uint256 blockTimestamp = block.timestamp * block.timestamp / block.timestamp * block.timestamp / block.timestamp;
        blockTimestamp = blockTimestamp + 1_720_700_948;
        vm.warp(blockTimestamp);

        address hook = address(new FullRestakeResetHook(7 days, 3));

        vm.startPrank(alice);
        delegator2.setHook(hook);
        AccessControl(address(delegator2)).grantRole(delegator2.OPERATOR_NETWORK_LIMIT_SET_ROLE(), hook);
        vm.stopPrank();

        address network = alice;
        _registerNetwork(network, alice);
        _setMaxNetworkLimit(address(delegator2), network, 0, type(uint256).max);

        _registerOperator(alice);

        _optInOperatorVault(vault2, alice);

        _optInOperatorNetwork(alice, address(network));

        _deposit(vault2, alice, depositAmount);

        _setNetworkLimitFull(delegator2, alice, network, type(uint256).max);

        _setOperatorNetworkLimit(delegator2, alice, network, alice, operatorNetworkLimit1);

        assertEq(delegator2.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator2.operatorNetworkLimit(network.subnetwork(0), alice), operatorNetworkLimit1);

        blockTimestamp = blockTimestamp + 1;
        vm.warp(blockTimestamp);

        _slash(slasher2, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator2.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator2.operatorNetworkLimit(network.subnetwork(0), alice), operatorNetworkLimit1);

        blockTimestamp = blockTimestamp + 7 days;
        vm.warp(blockTimestamp);

        _slash(slasher2, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator2.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator2.operatorNetworkLimit(network.subnetwork(0), alice), operatorNetworkLimit1);

        blockTimestamp = blockTimestamp + 3 days;
        vm.warp(blockTimestamp);

        _slash(slasher2, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator2.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator2.operatorNetworkLimit(network.subnetwork(0), alice), operatorNetworkLimit1);

        blockTimestamp = blockTimestamp + 5 days;
        vm.warp(blockTimestamp);

        _slash(slasher2, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator2.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator2.operatorNetworkLimit(network.subnetwork(0), alice), operatorNetworkLimit1);

        blockTimestamp = blockTimestamp + 3 days;
        vm.warp(blockTimestamp);

        _slash(slasher2, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator2.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator2.operatorNetworkLimit(network.subnetwork(0), alice), operatorNetworkLimit1);

        blockTimestamp = blockTimestamp + 3 days;
        vm.warp(blockTimestamp);

        _slash(slasher2, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator2.networkLimit(network.subnetwork(0)), type(uint256).max);
        assertEq(delegator2.operatorNetworkLimit(network.subnetwork(0), alice), 0);
    }

    function test_SlashWithHookRevertNotFullRestakeDelegator(
        uint256 operatorNetworkLimit1
    ) public {
        uint256 depositAmount = 1e18;
        uint256 slashAmount1 = 100;
        operatorNetworkLimit1 = bound(operatorNetworkLimit1, 1, type(uint256).max / 2);

        uint256 blockTimestamp = block.timestamp * block.timestamp / block.timestamp * block.timestamp / block.timestamp;
        blockTimestamp = blockTimestamp + 1_720_700_948;
        vm.warp(blockTimestamp);

        address hook = address(new FullRestakeResetHook(7 days, 3));

        address fullRestakeDelegatorImpl = address(
            new FullRestakeDelegator(
                address(networkRegistry),
                address(vaultFactory),
                address(operatorVaultOptInService),
                address(operatorNetworkOptInService),
                address(delegatorFactory),
                delegatorFactory.totalTypes()
            )
        );
        delegatorFactory.whitelist(fullRestakeDelegatorImpl);

        address[] memory networkLimitSetRoleHolders = new address[](1);
        networkLimitSetRoleHolders[0] = alice;
        address[] memory operatorNetworkLimitSetRoleHolders = new address[](1);
        operatorNetworkLimitSetRoleHolders[0] = alice;
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
                    IFullRestakeDelegator.InitParams({
                        baseParams: IBaseDelegator.BaseParams({
                            defaultAdminRoleHolder: alice,
                            hook: address(0),
                            hookSetRoleHolder: alice
                        }),
                        networkLimitSetRoleHolders: networkLimitSetRoleHolders,
                        operatorNetworkLimitSetRoleHolders: operatorNetworkLimitSetRoleHolders
                    })
                ),
                withSlasher: true,
                slasherIndex: 0,
                slasherParams: abi.encode(ISlasher.InitParams({baseParams: IBaseSlasher.BaseParams({isBurnerHook: false})}))
            })
        );

        (vault0, delegator0, slasher0) = (Vault(vault_), FullRestakeDelegator(delegator_), Slasher(slasher_));

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

        _setNetworkLimitFull(delegator0, alice, network, type(uint256).max);

        _setOperatorNetworkLimit(delegator0, alice, network, alice, operatorNetworkLimit1);

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
        assertEq(delegator0.operatorNetworkLimit(network.subnetwork(0), alice), operatorNetworkLimit1);
    }

    function test_SlashWithHookRevertNotVaultDelegator(
        uint256 operatorNetworkLimit1
    ) public {
        uint256 depositAmount = 1e18;
        uint256 slashAmount1 = 100;
        operatorNetworkLimit1 = bound(operatorNetworkLimit1, 1, type(uint256).max / 2);

        uint256 blockTimestamp = block.timestamp * block.timestamp / block.timestamp * block.timestamp / block.timestamp;
        blockTimestamp = blockTimestamp + 1_720_700_948;
        vm.warp(blockTimestamp);

        address hook = address(new FullRestakeResetHook(7 days, 3));

        vm.startPrank(alice);
        delegator2.setHook(hook);
        AccessControl(address(delegator2)).grantRole(delegator2.OPERATOR_NETWORK_LIMIT_SET_ROLE(), hook);
        vm.stopPrank();

        address network = alice;
        _registerNetwork(network, alice);
        _setMaxNetworkLimit(address(delegator2), network, 0, type(uint256).max);

        _registerOperator(alice);

        _optInOperatorVault(vault2, alice);

        _optInOperatorNetwork(alice, address(network));

        _deposit(vault2, alice, depositAmount);

        _setNetworkLimitFull(delegator2, alice, network, type(uint256).max);

        _setOperatorNetworkLimit(delegator2, alice, network, alice, operatorNetworkLimit1);

        blockTimestamp = blockTimestamp + 1;
        vm.warp(blockTimestamp);

        FakeDelegator fakeDelegator = new FakeDelegator(address(vault2), 1);
        vm.expectRevert(IFullRestakeResetHook.NotVaultDelegator.selector);
        fakeDelegator.onSlash(hook, network.subnetwork(0), alice, slashAmount1, uint48(blockTimestamp - 1), "");
    }
}
