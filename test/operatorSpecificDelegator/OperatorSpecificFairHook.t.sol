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
import {Subnetwork} from "@symbioticfi/core/src/contracts/libraries/Subnetwork.sol";

import {OperatorSpecificDecreaseHook} from "../../src/contracts/operatorSpecificDelegator/OperatorSpecificDecreaseHook.sol";

contract OperatorSpecificDecreaseHookTest is POCBaseTest {
    using Math for uint256;
    using Subnetwork for bytes32;
    using Subnetwork for address;

    Vault public vault0;
    OperatorSpecificDelegator public delegator0;
    Slasher public slasher0;

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

        address hook = address(new OperatorSpecificDecreaseHook());

        _registerOperator(alice);
        address[] memory networkLimitSetRoleHolders = new address[](1);
        networkLimitSetRoleHolders[0] = alice;
        (address vault_, address delegator_, address slasher_) = vaultConfigurator.create(
            IVaultConfigurator.InitParams({
                version: vaultFactory.lastVersion(),
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
        delegator0.grantRole(delegator0.NETWORK_LIMIT_SET_ROLE(), hook);
        vm.stopPrank();

        address network = alice;
        _registerNetwork(network, alice);
        _setMaxNetworkLimit(address(delegator0), network, 0, type(uint256).max);

        _registerOperator(bob);

        _optInOperatorVault(vault0, alice);

        _optInOperatorNetwork(alice, address(network));

        _optInOperatorVault(vault0, bob);

        _optInOperatorNetwork(bob, address(network));

        _deposit(vault0, alice, depositAmount);

        _setNetworkLimitOperator(delegator0, alice, network, networkLimit);

        assertEq(delegator0.networkLimit(network.subnetwork(0)), networkLimit);

        blockTimestamp = blockTimestamp + 1;
        vm.warp(blockTimestamp);

        uint256 stakeAtAlice = delegator0.stakeAt(network.subnetwork(0), alice, uint48(blockTimestamp - 1), "");
        uint256 stakeAtBob = delegator0.stakeAt(network.subnetwork(0), bob, uint48(blockTimestamp - 1), "");
        vm.assume(stakeAtAlice > slashAmount1);
        uint256 slashedAmount1 = _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator0.networkLimit(network.subnetwork(0)), networkLimit - slashedAmount1);
        assertLe(stakeAtBob, delegator0.stakeAt(network.subnetwork(0), bob, uint48(blockTimestamp), ""));

        uint256 slashedAmount2 = _slash(slasher0, alice, network, alice, slashAmount2, uint48(blockTimestamp - 1), "");

        assertEq(delegator0.networkLimit(network.subnetwork(0)), networkLimit - slashedAmount1 - slashedAmount2);
        assertLe(stakeAtBob, delegator0.stakeAt(network.subnetwork(0), bob, uint48(blockTimestamp), ""));
    }

    function test_SlashWithHookRevertNotOperatorSpecificDelegator(
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
        networkLimit = bound(networkLimit, 1, depositAmount);

        uint256 blockTimestamp = block.timestamp * block.timestamp / block.timestamp * block.timestamp / block.timestamp;
        blockTimestamp = blockTimestamp + 1_720_700_948;
        vm.warp(blockTimestamp);

        address hook = address(new OperatorSpecificDecreaseHook());

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
                version: vaultFactory.lastVersion(),
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
                delegatorIndex: 3,
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
        delegator0.grantRole(delegator0.NETWORK_LIMIT_SET_ROLE(), hook);
        vm.stopPrank();

        address network = alice;
        _registerNetwork(network, alice);
        _setMaxNetworkLimit(address(delegator0), network, 0, type(uint256).max);

        _registerOperator(bob);

        _optInOperatorVault(vault0, alice);

        _optInOperatorNetwork(alice, address(network));

        _optInOperatorVault(vault0, bob);

        _optInOperatorNetwork(bob, address(network));

        _deposit(vault0, alice, depositAmount);

        _setNetworkLimitOperator(delegator0, alice, network, networkLimit);

        blockTimestamp = blockTimestamp + 1;
        vm.warp(blockTimestamp);

        uint256 stakeAtAlice = delegator0.stakeAt(network.subnetwork(0), alice, uint48(blockTimestamp - 1), "");
        vm.assume(stakeAtAlice > slashAmount1);
        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator0.networkLimit(network.subnetwork(0)), networkLimit);
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
