// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {IFullRestakeResetHook} from "../../interfaces/fullRestakeDelegator/IFullRestakeResetHook.sol";

import {IDelegatorHook} from "@symbioticfi/core/src/interfaces/delegator/IDelegatorHook.sol";
import {IEntity} from "@symbioticfi/core/src/interfaces/common/IEntity.sol";
import {IFullRestakeDelegator} from "@symbioticfi/core/src/interfaces/delegator/IFullRestakeDelegator.sol";
import {IVault} from "@symbioticfi/core/src/interfaces/vault/IVault.sol";

import {CircularBuffer} from "@openzeppelin/contracts/utils/structs/CircularBuffer.sol";
import {Time} from "@openzeppelin/contracts/utils/types/Time.sol";

contract FullRestakeResetHook is IFullRestakeResetHook {
    using CircularBuffer for CircularBuffer.Bytes32CircularBuffer;

    /**
     * @inheritdoc IFullRestakeResetHook
     */
    uint48 public immutable PERIOD;

    /**
     * @inheritdoc IFullRestakeResetHook
     */
    uint256 public immutable SLASH_COUNT;

    mapping(address vault => mapping(address operator => CircularBuffer.Bytes32CircularBuffer buffer)) private
        _slashings;

    constructor(uint48 period_, uint256 slashCount_) {
        if (slashCount_ == 0) {
            revert InvalidSlashCount();
        }

        PERIOD = period_;
        SLASH_COUNT = slashCount_;
    }

    /**
     * @inheritdoc IDelegatorHook
     */
    function onSlash(
        bytes32 subnetwork,
        address operator,
        uint256, /* slashedAmount */
        uint48, /* captureTimestamp */
        bytes calldata /* data */
    ) external {
        if (IEntity(msg.sender).TYPE() != 1) {
            revert NotFullRestakeDelegator();
        }

        address vault = IFullRestakeDelegator(msg.sender).vault();

        if (IVault(vault).delegator() != msg.sender) {
            revert NotVaultDelegator();
        }

        uint256 slashCount_ = SLASH_COUNT;
        if (_slashings[vault][operator].count() == 0) {
            _slashings[vault][operator].setup(slashCount_);
        }

        if (IFullRestakeDelegator(msg.sender).operatorNetworkLimit(subnetwork, operator) == 0) {
            return;
        }

        _slashings[vault][operator].push(bytes32(uint256(Time.timestamp())));

        if (
            _slashings[vault][operator].count() == slashCount_
                && Time.timestamp() - uint256(_slashings[vault][operator].last(slashCount_ - 1)) <= PERIOD
        ) {
            IFullRestakeDelegator(msg.sender).setOperatorNetworkLimit(subnetwork, operator, 0);
        }
    }
}