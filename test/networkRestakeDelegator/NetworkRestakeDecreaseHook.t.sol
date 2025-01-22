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

import {NetworkRestakeDecreaseHook} from "../../src/contracts/networkRestakeDelegator/NetworkRestakeDecreaseHook.sol";

contract NetworkRestakeDecreaseHookTest is POCBaseTest {
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

        address hook = address(new NetworkRestakeDecreaseHook());

        vm.startPrank(alice);
        delegator1.setHook(hook);
        AccessControl(address(delegator1)).grantRole(delegator1.NETWORK_LIMIT_SET_ROLE(), hook);
        AccessControl(address(delegator1)).grantRole(delegator1.OPERATOR_NETWORK_SHARES_SET_ROLE(), hook);
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

    function test_SlashWithHookRevertNotNetworkRestakeDelegator(
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

        address hook = address(new NetworkRestakeDecreaseHook());

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
        AccessControl(address(delegator0)).grantRole(delegator0.NETWORK_LIMIT_SET_ROLE(), hook);
        AccessControl(address(delegator0)).grantRole(delegator0.OPERATOR_NETWORK_SHARES_SET_ROLE(), hook);
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

        _setNetworkLimitNetwork(delegator0, alice, network, networkLimit);

        _setOperatorNetworkShares(delegator0, alice, network, alice, operatorNetworkShares1);
        _setOperatorNetworkShares(delegator0, alice, network, bob, operatorNetworkShares2);

        blockTimestamp = blockTimestamp + 1;
        vm.warp(blockTimestamp);

        uint256 stakeAtAlice = delegator0.stakeAt(network.subnetwork(0), alice, uint48(blockTimestamp - 1), "");
        vm.assume(stakeAtAlice > slashAmount1);
        _slash(slasher0, alice, network, alice, slashAmount1, uint48(blockTimestamp - 1), "");

        assertEq(delegator0.networkLimit(network.subnetwork(0)), networkLimit);
        assertEq(
            delegator0.totalOperatorNetworkShares(network.subnetwork(0)),
            operatorNetworkShares1 + operatorNetworkShares2
        );
        assertEq(delegator0.operatorNetworkShares(network.subnetwork(0), alice), operatorNetworkShares1);
        assertEq(delegator0.operatorNetworkShares(network.subnetwork(0), bob), operatorNetworkShares2);
    }
}
