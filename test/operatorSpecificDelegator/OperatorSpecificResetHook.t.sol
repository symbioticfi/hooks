// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

import {POCBaseTest} from "@symbioticfi/core/test/POCBase.t.sol";
import {Vault} from "@symbioticfi/core/src/contracts/vault/Vault.sol";
import {OperatorSpecificDelegator} from "@symbioticfi/core/src/contracts/delegator/OperatorSpecificDelegator.sol";
import {Slasher} from "@symbioticfi/core/src/contracts/slasher/Slasher.sol";
import {IBaseSlasher} from "@symbioticfi/core/src/interfaces/slasher/IBaseSlasher.sol";
import {ISlasher} from "@symbioticfi/core/src/interfaces/slasher/ISlasher.sol";
import {IBaseDelegator} from "@symbioticfi/core/src/interfaces/delegator/IBaseDelegator.sol";
import {IOperatorSpecificDelegator} from "@symbioticfi/core/src/interfaces/delegator/IOperatorSpecificDelegator.sol";
import {IVault} from "@symbioticfi/core/src/interfaces/vault/IVault.sol";
import {IVaultConfigurator} from "@symbioticfi/core/src/interfaces/IVaultConfigurator.sol";

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {Subnetwork} from "@symbioticfi/core/src/contracts/libraries/Subnetwork.sol";

import {OperatorSpecificResetHook} from "../../src/contracts/operatorSpecificDelegator/OperatorSpecificResetHook.sol";
import {IOperatorSpecificResetHook} from "../../src/interfaces/operatorSpecificDelegator/IOperatorSpecificResetHook.sol";
import {FakeDelegator} from "../mocks/FakeDelegator.sol";

contract OperatorSpecificResetHookTest is POCBaseTest {
    using Math for uint256;
    using Subnetwork for bytes32;
    using Subnetwork for address;

    Vault public vault0;
    OperatorSpecificDelegator public delegator0;
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

        address hook = address(new OperatorSpecificResetHook(7 days, 3));

        _registerOperator(alice);
        address[] memory networkLimitSetRoleHolders = new address[](1);
        networkLimitSetRoleHolders[0] = alice;
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
                delegatorIndex: 2,
                delegatorParams: abi.encode(
                    IOperatorSpecificDelegator.InitParams({
                        baseParams: IBaseDelegator.BaseParams({
                            defaultAdminRoleHolder: alice,
                            hook: address(0),
                            hookSetRoleHolder: alice
                        }),
                        networkLimitSetRoleHolders: networkLimitSetRoleHolders,
                        operator: alice
                    })
                ),
                withSlasher: true,
                slasherIndex: 0,
                slasherParams: abi.encode(ISlasher.InitParams({baseParams: IBaseSlasher.BaseParams({isBurnerHook: false})}))
            })
        );

        (vault0, delegator0, slasher0) = (Vault(vault_), OperatorSpecificDelegator(delegator_), Slasher(slasher_));

        vm.startPrank(alice);
        delegator0.setHook(hook);
        AccessControl(address(delegator0)).grantRole(delegator0.NETWORK_LIMIT_SET_ROLE(), hook);
        vm.stopPrank();

        address network = alice;
        _registerNetwork(network, alice);
        _setMaxNetworkLimit(address(delegator0), network, 0, type(uint256).max);

        _optInOperatorVault(vault0, alice);

        _optInOperatorNetwork(alice, address(network));

        _deposit(vault0, alice, depositAmount);

        _setNetworkLimitOperator(delegator0, alice, network, type(uint256).max);

        assertEq(delegator0.networkLimit(network.subnetwork(0)), type(uint256).max);

        blockTimestamp = blockTimestamp + 1;
        vm.warp(blockTimestamp);

        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator0.networkLimit(network.subnetwork(0)), type(uint256).max);

        blockTimestamp = blockTimestamp + 7 days;
        vm.warp(blockTimestamp);

        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator0.networkLimit(network.subnetwork(0)), type(uint256).max);

        blockTimestamp = blockTimestamp + 3 days;
        vm.warp(blockTimestamp);

        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator0.networkLimit(network.subnetwork(0)), type(uint256).max);

        blockTimestamp = blockTimestamp + 5 days;
        vm.warp(blockTimestamp);

        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator0.networkLimit(network.subnetwork(0)), type(uint256).max);

        blockTimestamp = blockTimestamp + 3 days;
        vm.warp(blockTimestamp);

        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator0.networkLimit(network.subnetwork(0)), type(uint256).max);

        blockTimestamp = blockTimestamp + 3 days;
        vm.warp(blockTimestamp);

        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator0.networkLimit(network.subnetwork(0)), 0);
    }

    function test_SlashWithHookRevertNotOperatorSpecificDelegator(
        uint256 operatorNetworkShares1
    ) public {
        uint256 depositAmount = 1e18;
        uint256 slashAmount1 = 100;
        operatorNetworkShares1 = bound(operatorNetworkShares1, 1, type(uint256).max / 2);

        uint256 blockTimestamp = block.timestamp * block.timestamp / block.timestamp * block.timestamp / block.timestamp;
        blockTimestamp = blockTimestamp + 1_720_700_948;
        vm.warp(blockTimestamp);

        address hook = address(new OperatorSpecificResetHook(7 days, 3));

        address operatorSpecificDelegatorImpl = address(
            new OperatorSpecificDelegator(
                address(operatorRegistry),
                address(networkRegistry),
                address(vaultFactory),
                address(operatorVaultOptInService),
                address(operatorNetworkOptInService),
                address(delegatorFactory),
                delegatorFactory.totalTypes()
            )
        );
        delegatorFactory.whitelist(operatorSpecificDelegatorImpl);

        _registerOperator(alice);
        address[] memory networkLimitSetRoleHolders = new address[](1);
        networkLimitSetRoleHolders[0] = alice;
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
                    IOperatorSpecificDelegator.InitParams({
                        baseParams: IBaseDelegator.BaseParams({
                            defaultAdminRoleHolder: alice,
                            hook: address(0),
                            hookSetRoleHolder: alice
                        }),
                        networkLimitSetRoleHolders: networkLimitSetRoleHolders,
                        operator: alice
                    })
                ),
                withSlasher: true,
                slasherIndex: 0,
                slasherParams: abi.encode(ISlasher.InitParams({baseParams: IBaseSlasher.BaseParams({isBurnerHook: false})}))
            })
        );

        (vault0, delegator0, slasher0) = (Vault(vault_), OperatorSpecificDelegator(delegator_), Slasher(slasher_));

        vm.startPrank(alice);
        delegator0.setHook(hook);
        vm.stopPrank();

        address network = alice;
        _registerNetwork(network, alice);
        _setMaxNetworkLimit(address(delegator0), network, 0, type(uint256).max);

        _optInOperatorVault(vault0, alice);

        _optInOperatorNetwork(alice, address(network));

        _deposit(vault0, alice, depositAmount);

        _setNetworkLimitOperator(delegator0, alice, network, type(uint256).max);

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

        address hook = address(new OperatorSpecificResetHook(7 days, 3));

        _registerOperator(alice);
        address[] memory networkLimitSetRoleHolders = new address[](1);
        networkLimitSetRoleHolders[0] = alice;
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
                delegatorIndex: 2,
                delegatorParams: abi.encode(
                    IOperatorSpecificDelegator.InitParams({
                        baseParams: IBaseDelegator.BaseParams({
                            defaultAdminRoleHolder: alice,
                            hook: address(0),
                            hookSetRoleHolder: alice
                        }),
                        networkLimitSetRoleHolders: networkLimitSetRoleHolders,
                        operator: alice
                    })
                ),
                withSlasher: true,
                slasherIndex: 0,
                slasherParams: abi.encode(ISlasher.InitParams({baseParams: IBaseSlasher.BaseParams({isBurnerHook: false})}))
            })
        );

        (vault0, delegator0, slasher0) = (Vault(vault_), OperatorSpecificDelegator(delegator_), Slasher(slasher_));

        vm.startPrank(alice);
        delegator0.setHook(hook);
        AccessControl(address(delegator0)).grantRole(delegator0.NETWORK_LIMIT_SET_ROLE(), hook);
        vm.stopPrank();

        address network = alice;
        _registerNetwork(network, alice);
        _setMaxNetworkLimit(address(delegator0), network, 0, type(uint256).max);

        _optInOperatorVault(vault0, alice);

        _optInOperatorNetwork(alice, address(network));

        _deposit(vault0, alice, depositAmount);

        _setNetworkLimitOperator(delegator0, alice, network, type(uint256).max);

        blockTimestamp = blockTimestamp + 1;
        vm.warp(blockTimestamp);

        FakeDelegator fakeDelegator = new FakeDelegator(address(vault0), 2);
        vm.expectRevert(IOperatorSpecificResetHook.NotVaultDelegator.selector);
        fakeDelegator.onSlash(hook, network.subnetwork(0), alice, slashAmount1, uint48(blockTimestamp - 1), "");
    }

    function _setNetworkLimitOperator(
        OperatorSpecificDelegator delegator,
        address user,
        address network,
        uint256 amount
    ) internal {
        vm.startPrank(user);
        delegator.setNetworkLimit(network.subnetwork(0), amount);
        vm.stopPrank();
    }
}
