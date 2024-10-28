// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IDelegatorHook} from "@symbioticfi/core/src/interfaces/delegator/IDelegatorHook.sol";

interface INetworkRestakeResetHook is IDelegatorHook {
    error InvalidSlashCount();
    error NotNetworkRestakeDelegator();
    error NotVaultDelegator();

    /**
     * @notice Get a period during which the slashing should occur to reset the operator's stake.
     * @return threshold period
     */
    function PERIOD() external view returns (uint48);

    /**
     * @notice Get a number of slashes that should occur during the PERIOD to reset the operator's stake.
     * @return threshold count
     */
    function SLASH_COUNT() external view returns (uint256);
}
