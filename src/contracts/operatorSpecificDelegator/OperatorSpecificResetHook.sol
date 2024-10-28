// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {IOperatorSpecificResetHook} from "../../interfaces/operatorSpecificDelegator/IOperatorSpecificResetHook.sol";

import {IDelegatorHook} from "@symbioticfi/core/src/interfaces/delegator/IDelegatorHook.sol";
import {IEntity} from "@symbioticfi/core/src/interfaces/common/IEntity.sol";
import {IOperatorSpecificDelegator} from "@symbioticfi/core/src/interfaces/delegator/IOperatorSpecificDelegator.sol";
import {IVault} from "@symbioticfi/core/src/interfaces/vault/IVault.sol";

import {CircularBuffer} from "@openzeppelin/contracts/utils/structs/CircularBuffer.sol";
import {Time} from "@openzeppelin/contracts/utils/types/Time.sol";

contract OperatorSpecificResetHook is IOperatorSpecificResetHook {
    using CircularBuffer for CircularBuffer.Bytes32CircularBuffer;

    /**
     * @inheritdoc IOperatorSpecificResetHook
     */
    uint48 public immutable PERIOD;

    /**
     * @inheritdoc IOperatorSpecificResetHook
     */
    uint256 public immutable SLASH_COUNT;

    mapping(address vault => CircularBuffer.Bytes32CircularBuffer buffer) private _slashings;

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
        address, /* operator */
        uint256, /* slashedAmount */
        uint48, /* captureTimestamp */
        bytes calldata /* data */
    ) external {
        if (IEntity(msg.sender).TYPE() != 2) {
            revert NotOperatorSpecificDelegator();
        }

        address vault = IOperatorSpecificDelegator(msg.sender).vault();

        if (IVault(vault).delegator() != msg.sender) {
            revert NotVaultDelegator();
        }

        uint256 slashCount_ = SLASH_COUNT;
        if (_slashings[vault].count() == 0) {
            _slashings[vault].setup(slashCount_);
        }

        if (IOperatorSpecificDelegator(msg.sender).networkLimit(subnetwork) == 0) {
            return;
        }

        _slashings[vault].push(bytes32(uint256(Time.timestamp())));

        if (
            _slashings[vault].count() == slashCount_
                && Time.timestamp() - uint256(_slashings[vault].last(slashCount_ - 1)) <= PERIOD
        ) {
            IOperatorSpecificDelegator(msg.sender).setNetworkLimit(subnetwork, 0);
        }
    }
}
