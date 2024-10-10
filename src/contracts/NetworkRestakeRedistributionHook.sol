// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {INetworkRestakeRedistributionHook} from "../interfaces/INetworkRestakeRedistributionHook.sol";

import {IBaseSlasher} from "@symbioticfi/core/src/interfaces/slasher/IBaseSlasher.sol";
import {IDelegatorHook} from "@symbioticfi/core/src/interfaces/delegator/IDelegatorHook.sol";
import {IEntity} from "@symbioticfi/core/src/interfaces/common/IEntity.sol";
import {INetworkRestakeDelegator} from "@symbioticfi/core/src/interfaces/delegator/INetworkRestakeDelegator.sol";
import {IVault} from "@symbioticfi/core/src/interfaces/vault/IVault.sol";

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

contract NetworkRestakeRedistributionHook is INetworkRestakeRedistributionHook {
    using Math for uint256;

    /**
     * @inheritdoc IDelegatorHook
     */
    function onSlash(
        bytes32 subnetwork,
        address operator,
        uint256 slashedAmount,
        uint48 captureTimestamp,
        bytes calldata data
    ) external {
        if (IEntity(msg.sender).TYPE() != 0) {
            revert NotNetworkRestakeDelegator();
        }

        if (slashedAmount == 0) {
            return;
        }

        address vault = INetworkRestakeDelegator(msg.sender).vault();
        address slasher = IVault(vault).slasher();

        uint256 prevSlashableStake = Math.min(
            IVault(vault).activeStakeAt(captureTimestamp, new bytes(0))
                - (
                    (IBaseSlasher(slasher).globalCumulativeSlash() - slashedAmount)
                        - IBaseSlasher(slasher).globalCumulativeSlashAt(captureTimestamp, new bytes(0))
                ),
            INetworkRestakeDelegator(msg.sender).stakeAt(subnetwork, operator, captureTimestamp, new bytes(0))
                - (
                    (IBaseSlasher(slasher).cumulativeSlash(subnetwork, operator) - slashedAmount)
                        - IBaseSlasher(slasher).cumulativeSlashAt(subnetwork, operator, captureTimestamp, new bytes(0))
                )
        );

        INetworkRestakeDelegator(msg.sender).setOperatorNetworkShares(
            subnetwork,
            operator,
            (prevSlashableStake - slashedAmount).mulDiv(
                INetworkRestakeDelegator(msg.sender).operatorNetworkShares(subnetwork, operator), prevSlashableStake
            )
        );
    }
}
