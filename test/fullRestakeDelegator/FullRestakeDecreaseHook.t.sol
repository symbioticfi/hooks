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

import {FullRestakeDecreaseHook} from "../../src/contracts/fullRestakeDelegator/FullRestakeDecreaseHook.sol";

contract FullRestakeDecreaseHookTest is POCBaseTest {
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
        uint256 depositAmount,
        uint256 operatorNetworkLimit1,
        uint256 operatorNetworkLimit2,
        uint256 slashAmount1,
        uint256 slashAmount2,
        uint256 networkLimit
    ) public {
        depositAmount = bound(depositAmount, 100, 100 * 10 ** 18);
        operatorNetworkLimit1 = bound(operatorNetworkLimit1, 1, type(uint256).max / 2);
        operatorNetworkLimit2 = bound(operatorNetworkLimit2, 1, type(uint256).max / 2);
        slashAmount1 = bound(slashAmount1, 1, type(uint256).max);
        slashAmount2 = bound(slashAmount2, 1, type(uint256).max);
        networkLimit = bound(networkLimit, 1, depositAmount);

        uint256 blockTimestamp = block.timestamp * block.timestamp / block.timestamp * block.timestamp / block.timestamp;
        blockTimestamp = blockTimestamp + 1_720_700_948;
        vm.warp(blockTimestamp);

        address hook = address(new FullRestakeDecreaseHook());

        vm.startPrank(alice);
        delegator2.setHook(hook);
        AccessControl(address(delegator2)).grantRole(delegator2.NETWORK_LIMIT_SET_ROLE(), hook);
        AccessControl(address(delegator2)).grantRole(delegator2.OPERATOR_NETWORK_LIMIT_SET_ROLE(), hook);
        vm.stopPrank();

        address network = alice;
        _registerNetwork(network, alice);
        _setMaxNetworkLimit(address(delegator2), network, 0, type(uint256).max);

        _registerOperator(alice);
        _registerOperator(bob);

        _optInOperatorVault(vault2, alice);

        _optInOperatorNetwork(alice, address(network));

        _optInOperatorVault(vault2, bob);

        _optInOperatorNetwork(bob, address(network));

        _deposit(vault2, alice, depositAmount);

        _setNetworkLimitFull(delegator2, alice, network, networkLimit);

        _setOperatorNetworkLimit(delegator2, alice, network, alice, operatorNetworkLimit1);
        _setOperatorNetworkLimit(delegator2, alice, network, bob, operatorNetworkLimit2);

        assertEq(delegator2.networkLimit(network.subnetwork(0)), networkLimit);
        assertEq(delegator2.operatorNetworkLimit(network.subnetwork(0), alice), operatorNetworkLimit1);
        assertEq(delegator2.operatorNetworkLimit(network.subnetwork(0), bob), operatorNetworkLimit2);

        blockTimestamp = blockTimestamp + 1;
        vm.warp(blockTimestamp);

        uint256 stakeAtAlice = delegator2.stakeAt(network.subnetwork(0), alice, uint48(blockTimestamp - 1), "");

        vm.assume(stakeAtAlice > slashAmount1);
        uint256 slashedAmount1 = _slash(slasher2, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        uint256 slashedOperatorLimit1 = slashedAmount1;

        assertEq(delegator2.networkLimit(network.subnetwork(0)), networkLimit - slashedAmount1);
        assertEq(
            delegator2.operatorNetworkLimit(network.subnetwork(0), alice), operatorNetworkLimit1 - slashedOperatorLimit1
        );
        assertEq(delegator2.operatorNetworkLimit(network.subnetwork(0), bob), operatorNetworkLimit2);

        uint256 slashedAmount2 = _slash(slasher2, alice, network, alice, slashAmount2, uint48(blockTimestamp - 1), "");

        uint256 slashedOperatorLimit2 = slashedAmount2;

        assertEq(delegator2.networkLimit(network.subnetwork(0)), networkLimit - slashedAmount1 - slashedAmount2);
        assertApproxEqAbs(
            delegator2.operatorNetworkLimit(network.subnetwork(0), alice),
            operatorNetworkLimit1 - slashedOperatorLimit1
                - Math.min(operatorNetworkLimit1 - slashedOperatorLimit1, slashedOperatorLimit2),
            1
        );
        assertEq(delegator2.operatorNetworkLimit(network.subnetwork(0), bob), operatorNetworkLimit2);
    }

    function test_SlashWithHookRevertNotFullRestakeDelegator(
        uint256 depositAmount,
        uint256 operatorNetworkLimit1,
        uint256 operatorNetworkLimit2,
        uint256 slashAmount1,
        uint256 slashAmount2,
        uint256 networkLimit
    ) public {
        depositAmount = bound(depositAmount, 100, 100 * 10 ** 18);
        operatorNetworkLimit1 = bound(operatorNetworkLimit1, 1, type(uint256).max / 2);
        operatorNetworkLimit2 = bound(operatorNetworkLimit2, 1, type(uint256).max / 2);
        slashAmount1 = bound(slashAmount1, 1, type(uint256).max);
        networkLimit = bound(networkLimit, 1, depositAmount);

        uint256 blockTimestamp = block.timestamp * block.timestamp / block.timestamp * block.timestamp / block.timestamp;
        blockTimestamp = blockTimestamp + 1_720_700_948;
        vm.warp(blockTimestamp);

        address hook = address(new FullRestakeDecreaseHook());

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
        AccessControl(address(delegator0)).grantRole(delegator0.NETWORK_LIMIT_SET_ROLE(), hook);
        AccessControl(address(delegator0)).grantRole(delegator0.OPERATOR_NETWORK_LIMIT_SET_ROLE(), hook);
        vm.stopPrank();

        address network = alice;
        _registerNetwork(network, alice);
        _setMaxNetworkLimit(address(delegator0), network, 0, type(uint256).max);

        _registerOperator(alice);
        _registerOperator(bob);

        _optInOperatorVault(vault0, alice);

        _optInOperatorNetwork(alice, address(network));

        _optInOperatorVault(vault0, bob);

        _optInOperatorNetwork(bob, address(network));

        _deposit(vault0, alice, depositAmount);

        _setNetworkLimitFull(delegator0, alice, network, networkLimit);

        _setOperatorNetworkLimit(delegator0, alice, network, alice, operatorNetworkLimit1);
        _setOperatorNetworkLimit(delegator0, alice, network, bob, operatorNetworkLimit2);

        blockTimestamp = blockTimestamp + 1;
        vm.warp(blockTimestamp);

        uint256 stakeAtAlice = delegator0.stakeAt(network.subnetwork(0), alice, uint48(blockTimestamp - 1), "");
        vm.assume(stakeAtAlice > slashAmount1);
        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator0.networkLimit(network.subnetwork(0)), networkLimit);
        assertEq(delegator0.operatorNetworkLimit(network.subnetwork(0), alice), operatorNetworkLimit1);
        assertEq(delegator0.operatorNetworkLimit(network.subnetwork(0), bob), operatorNetworkLimit2);
    }
}
