// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {IDelegatorHook} from "@symbioticfi/core/src/interfaces/delegator/IDelegatorHook.sol";

interface INetworkRestakeFairHook is IDelegatorHook {
    error NotNetworkRestakeDelegator();
}
