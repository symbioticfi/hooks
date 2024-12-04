// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {FullRestakeDecreaseHook as SymbioticFullRestakeDecreaseHook} from
    "../../src/contracts/fullRestakeDelegator/FullRestakeDecreaseHook.sol";
import {FullRestakeResetHook as SymbioticFullRestakeResetHook} from
    "../../src/contracts/fullRestakeDelegator/FullRestakeResetHook.sol";
import {NetworkRestakeDecreaseHook as SymbioticNetworkRestakeDecreaseHook} from
    "../../src/contracts/networkRestakeDelegator/NetworkRestakeDecreaseHook.sol";
import {NetworkRestakeResetHook as SymbioticNetworkRestakeResetHook} from
    "../../src/contracts/networkRestakeDelegator/NetworkRestakeResetHook.sol";
import {NetworkRestakeRedistributeHook as SymbioticNetworkRestakeRedistributeHook} from
    "../../src/contracts/networkRestakeDelegator/NetworkRestakeRedistributeHook.sol";
import {OperatorSpecificDecreaseHook as SymbioticOperatorSpecificDecreaseHook} from
    "../../src/contracts/operatorSpecificDelegator/OperatorSpecificDecreaseHook.sol";
import {OperatorSpecificResetHook as SymbioticOperatorSpecificResetHook} from
    "../../src/contracts/operatorSpecificDelegator/OperatorSpecificResetHook.sol";

interface SymbioticHooksImportsContracts {}
