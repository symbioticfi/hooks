// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IFullRestakeDecreaseHook as ISymbioticFullRestakeDecreaseHook} from
    "../../src/interfaces/fullRestakeDelegator/IFullRestakeDecreaseHook.sol";
import {IFullRestakeResetHook as ISymbioticFullRestakeResetHook} from
    "../../src/interfaces/fullRestakeDelegator/IFullRestakeResetHook.sol";
import {INetworkRestakeDecreaseHook as ISymbioticNetworkRestakeDecreaseHook} from
    "../../src/interfaces/networkRestakeDelegator/INetworkRestakeDecreaseHook.sol";
import {INetworkRestakeResetHook as ISymbioticNetworkRestakeResetHook} from
    "../../src/interfaces/networkRestakeDelegator/INetworkRestakeResetHook.sol";
import {INetworkRestakeRedistributeHook as ISymbioticNetworkRestakeRedistributeHook} from
    "../../src/interfaces/networkRestakeDelegator/INetworkRestakeRedistributeHook.sol";
import {IOperatorSpecificDecreaseHook as ISymbioticOperatorSpecificDecreaseHook} from
    "../../src/interfaces/operatorSpecificDelegator/IOperatorSpecificDecreaseHook.sol";
import {IOperatorSpecificResetHook as ISymbioticOperatorSpecificResetHook} from
    "../../src/interfaces/operatorSpecificDelegator/IOperatorSpecificResetHook.sol";

interface SymbioticHooksImports {}
