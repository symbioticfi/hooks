// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {IDelegatorHook} from "@symbioticfi/core/src/interfaces/delegator/IDelegatorHook.sol";

interface INetworkRestakeResetHook is IDelegatorHook {
    error InvalidSlashCount();
    error NotNetworkRestakeDelegator();
}
