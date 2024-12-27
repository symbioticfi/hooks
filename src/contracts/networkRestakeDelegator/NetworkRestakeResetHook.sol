// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {INetworkRestakeResetHook} from "../../interfaces/networkRestakeDelegator/INetworkRestakeResetHook.sol";

import {IDelegatorHook} from "@symbioticfi/core/src/interfaces/delegator/IDelegatorHook.sol";
import {IEntity} from "@symbioticfi/core/src/interfaces/common/IEntity.sol";
import {INetworkRestakeDelegator} from "@symbioticfi/core/src/interfaces/delegator/INetworkRestakeDelegator.sol";
import {IVault} from "@symbioticfi/core/src/interfaces/vault/IVault.sol";

import {CircularBuffer} from "@openzeppelin/contracts/utils/structs/CircularBuffer.sol";
import {Time} from "@openzeppelin/contracts/utils/types/Time.sol";

contract NetworkRestakeResetHook is INetworkRestakeResetHook {
    using CircularBuffer for CircularBuffer.Bytes32CircularBuffer;

    /**
     * @inheritdoc INetworkRestakeResetHook
     */
    uint48 public immutable PERIOD;

    /**
     * @inheritdoc INetworkRestakeResetHook
     */
    uint256 public immutable SLASH_COUNT;

    mapping(
        address vault
            => mapping(bytes32 subnetwork => mapping(address operator => CircularBuffer.Bytes32CircularBuffer buffer))
    ) private _slashings;

    constructor(uint48 period, uint256 slashCount) {
        if (slashCount == 0) {
            revert InvalidSlashCount();
        }

        PERIOD = period;
        SLASH_COUNT = slashCount;
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
        if (IEntity(msg.sender).TYPE() != 0) {
            revert NotNetworkRestakeDelegator();
        }

        address vault = INetworkRestakeDelegator(msg.sender).vault();

        if (IVault(vault).delegator() != msg.sender) {
            revert NotVaultDelegator();
        }

        if (_slashings[vault][subnetwork][operator].count() == 0) {
            _slashings[vault][subnetwork][operator].setup(SLASH_COUNT);
        }

        if (INetworkRestakeDelegator(msg.sender).operatorNetworkShares(subnetwork, operator) == 0) {
            return;
        }

        _slashings[vault][subnetwork][operator].push(bytes32(uint256(Time.timestamp())));

        if (
            _slashings[vault][subnetwork][operator].count() == SLASH_COUNT
                && Time.timestamp() - uint256(_slashings[vault][subnetwork][operator].last(SLASH_COUNT - 1)) <= PERIOD
        ) {
            INetworkRestakeDelegator(msg.sender).setOperatorNetworkShares(subnetwork, operator, 0);
        }
    }
}
