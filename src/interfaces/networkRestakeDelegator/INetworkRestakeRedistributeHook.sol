// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IDelegatorHook} from "@symbioticfi/core/src/interfaces/delegator/IDelegatorHook.sol";

interface INetworkRestakeRedistributeHook is IDelegatorHook {
    error NotNetworkRestakeDelegator();
}
