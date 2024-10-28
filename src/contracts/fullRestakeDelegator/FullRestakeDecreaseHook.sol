// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {IFullRestakeDecreaseHook} from "../../interfaces/fullRestakeDelegator/IFullRestakeDecreaseHook.sol";

import {IDelegatorHook} from "@symbioticfi/core/src/interfaces/delegator/IDelegatorHook.sol";
import {IEntity} from "@symbioticfi/core/src/interfaces/common/IEntity.sol";
import {IFullRestakeDelegator} from "@symbioticfi/core/src/interfaces/delegator/IFullRestakeDelegator.sol";

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

contract FullRestakeDecreaseHook is IFullRestakeDecreaseHook {
    using Math for uint256;

    /**
     * @inheritdoc IDelegatorHook
     */
    function onSlash(
        bytes32 subnetwork,
        address operator,
        uint256 slashedAmount,
        uint48, /* captureTimestamp */
        bytes calldata /* data */
    ) external {
        if (IEntity(msg.sender).TYPE() != 1) {
            revert NotFullRestakeDelegator();
        }

        if (slashedAmount == 0) {
            return;
        }

        uint256 networkLimit = IFullRestakeDelegator(msg.sender).networkLimit(subnetwork);
        if (networkLimit != 0) {
            IFullRestakeDelegator(msg.sender).setNetworkLimit(
                subnetwork, networkLimit - Math.min(slashedAmount, networkLimit)
            );
        }

        uint256 operatorNetworkLimit = IFullRestakeDelegator(msg.sender).operatorNetworkLimit(subnetwork, operator);
        if (operatorNetworkLimit != 0) {
            IFullRestakeDelegator(msg.sender).setOperatorNetworkLimit(
                subnetwork, operator, operatorNetworkLimit - Math.min(slashedAmount, operatorNetworkLimit)
            );
        }
    }
}
