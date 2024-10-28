// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {INetworkRestakeRedistributeHook} from
    "../../interfaces/networkRestakeDelegator/INetworkRestakeRedistributeHook.sol";

import {IBaseSlasher} from "@symbioticfi/core/src/interfaces/slasher/IBaseSlasher.sol";
import {IDelegatorHook} from "@symbioticfi/core/src/interfaces/delegator/IDelegatorHook.sol";
import {IEntity} from "@symbioticfi/core/src/interfaces/common/IEntity.sol";
import {INetworkRestakeDelegator} from "@symbioticfi/core/src/interfaces/delegator/INetworkRestakeDelegator.sol";
import {IVault} from "@symbioticfi/core/src/interfaces/vault/IVault.sol";
import {IBaseSlasher} from "@symbioticfi/core/src/interfaces/slasher/IBaseSlasher.sol";
import {ISlasher} from "@symbioticfi/core/src/interfaces/slasher/ISlasher.sol";
import {IVetoSlasher} from "@symbioticfi/core/src/interfaces/slasher/IVetoSlasher.sol";

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

contract NetworkRestakeRedistributeHook is INetworkRestakeRedistributeHook {
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

        IBaseSlasher.GeneralDelegatorData memory generalData = abi.decode(data, (IBaseSlasher.GeneralDelegatorData));
        uint256 slashableStake;
        if (generalData.slasherType == 0) {
            ISlasher.DelegatorData memory delegatorData = abi.decode(generalData.data, (ISlasher.DelegatorData));
            slashableStake = delegatorData.slashableStake;
        } else if (generalData.slasherType == 1) {
            IVetoSlasher.DelegatorData memory delegatorData = abi.decode(generalData.data, (IVetoSlasher.DelegatorData));
            slashableStake = delegatorData.slashableStake;
        } else {
            address slasher = IVault(INetworkRestakeDelegator(msg.sender).vault()).slasher();
            slashableStake = INetworkRestakeDelegator(msg.sender).stakeAt(
                subnetwork, operator, captureTimestamp, new bytes(0)
            )
                - (
                    (IBaseSlasher(slasher).cumulativeSlash(subnetwork, operator) - slashedAmount)
                        - IBaseSlasher(slasher).cumulativeSlashAt(subnetwork, operator, captureTimestamp, new bytes(0))
                );
        }

        uint256 operatorNetworkShares = INetworkRestakeDelegator(msg.sender).operatorNetworkShares(subnetwork, operator);
        if (operatorNetworkShares != 0) {
            INetworkRestakeDelegator(msg.sender).setOperatorNetworkShares(
                subnetwork, operator, (slashableStake - slashedAmount).mulDiv(operatorNetworkShares, slashableStake)
            );
        }
    }
}
