// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {INetworkRestakeResetHook} from "../../interfaces/networkRestakeDelegator/INetworkRestakeResetHook.sol";

import {IDelegatorHook} from "@symbioticfi/core/src/interfaces/delegator/IDelegatorHook.sol";
import {IEntity} from "@symbioticfi/core/src/interfaces/common/IEntity.sol";
import {INetworkRestakeDelegator} from "@symbioticfi/core/src/interfaces/delegator/INetworkRestakeDelegator.sol";

import {CircularBuffer} from "@openzeppelin/contracts/utils/structs/CircularBuffer.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {Time} from "@openzeppelin/contracts/utils/types/Time.sol";

contract NetworkRestakeResetHook is INetworkRestakeResetHook {
    using Math for uint256;
    using CircularBuffer for CircularBuffer.Bytes32CircularBuffer;

    uint48 public period;
    uint256 public slashCount;

    mapping(address vault => mapping(address operator => CircularBuffer.Bytes32CircularBuffer buffer)) private
        _slashings;

    constructor(uint48 period_, uint256 slashCount_) {
        if (slashCount_ == 0) {
            revert InvalidSlashCount();
        }

        period = period_;
        slashCount = slashCount_;
    }

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

        address vault = INetworkRestakeDelegator(msg.sender).vault();

        uint256 slashCount_ = slashCount;
        if (_slashings[vault][operator].count() == 0) {
            _slashings[vault][operator].setup(slashCount_);
        }

        _slashings[vault][operator].push(bytes32(uint256(Time.timestamp())));

        if (
            _slashings[vault][operator].count() == slashCount_
                && Time.timestamp() - uint256(_slashings[vault][operator].last(slashCount_ - 1)) <= period
        ) {
            INetworkRestakeDelegator(msg.sender).setOperatorNetworkShares(subnetwork, operator, 0);
        }
    }
}
