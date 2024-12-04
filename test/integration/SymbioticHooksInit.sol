// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@symbioticfi/core/test/integration/SymbioticCoreInit.sol";

import "./SymbioticHooksImports.sol";

import {SymbioticHooksConstants} from "./SymbioticHooksConstants.sol";
import {SymbioticHooksBindings} from "./SymbioticHooksBindings.sol";

import {SafeERC20, IERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

contract SymbioticHooksInit is SymbioticCoreInit, SymbioticHooksBindings {
    using SafeERC20 for IERC20;
    using Math for uint256;

    // General config

    string public SYMBIOTIC_HOOKS_PROJECT_ROOT = "";

    function setUp() public virtual override {
        SymbioticCoreInit.setUp();
    }

    // ------------------------------------------------------------ HOOKS-RELATED HELPERS ------------------------------------------------------------ //

    function _getNetworkRestakeDecreaseHook_SymbioticHooks() internal virtual returns (address) {
        return deployCode(
            string.concat(
                SYMBIOTIC_HOOKS_PROJECT_ROOT, "out/NetworkRestakeDecreaseHook.sol/NetworkRestakeDecreaseHook.json"
            )
        );
    }

    function _getNetworkRestakeRedistributeHook_SymbioticHooks() internal virtual returns (address) {
        return deployCode(
            string.concat(
                SYMBIOTIC_HOOKS_PROJECT_ROOT,
                "out/NetworkRestakeRedistributeHook.sol/NetworkRestakeRedistributeHook.json"
            )
        );
    }

    function _getNetworkRestakeResetHook_SymbioticHooks(
        uint48 period,
        uint256 slashCount
    ) internal virtual returns (address) {
        return deployCode(
            string.concat(SYMBIOTIC_HOOKS_PROJECT_ROOT, "out/NetworkRestakeResetHook.sol/NetworkRestakeResetHook.json"),
            abi.encode(period, slashCount)
        );
    }

    function _getNetworkRestakeResetHook_SymbioticHooks() internal virtual returns (address) {
        return _getNetworkRestakeResetHook_SymbioticHooks(7 days, 3);
    }

    function _getFullRestakeDecreaseHook_SymbioticHooks() internal virtual returns (address) {
        return deployCode(
            string.concat(SYMBIOTIC_HOOKS_PROJECT_ROOT, "out/FullRestakeDecreaseHook.sol/FullRestakeDecreaseHook.json")
        );
    }

    function _getFullRestakeResetHook_SymbioticHooks(
        uint48 period,
        uint256 slashCount
    ) internal virtual returns (address) {
        return deployCode(
            string.concat(SYMBIOTIC_HOOKS_PROJECT_ROOT, "out/FullRestakeResetHook.sol/FullRestakeResetHook.json"),
            abi.encode(period, slashCount)
        );
    }

    function _getFullRestakeResetHook_SymbioticHooks() internal virtual returns (address) {
        return _getFullRestakeResetHook_SymbioticHooks(7 days, 3);
    }

    function _getOperatorSpecificDecreaseHook_SymbioticHooks() internal virtual returns (address) {
        return deployCode(
            string.concat(
                SYMBIOTIC_HOOKS_PROJECT_ROOT, "out/OperatorSpecificDecreaseHook.sol/OperatorSpecificDecreaseHook.json"
            )
        );
    }

    function _getOperatorSpecificResetHook_SymbioticHooks(
        uint48 period,
        uint256 slashCount
    ) internal virtual returns (address) {
        return deployCode(
            string.concat(
                SYMBIOTIC_HOOKS_PROJECT_ROOT, "out/OperatorSpecificResetHook.sol/OperatorSpecificResetHook.json"
            )
        );
    }

    function _getOperatorSpecificResetHook_SymbioticHooks() internal virtual returns (address) {
        return _getOperatorSpecificResetHook_SymbioticHooks(7 days, 3);
    }

    function _getDecreaseHook_SymbioticHooks(
        uint256 delegatorIndex
    ) internal virtual returns (address) {
        if (delegatorIndex == 0) {
            return _getNetworkRestakeDecreaseHook_SymbioticHooks();
        } else if (delegatorIndex == 1) {
            return _getFullRestakeDecreaseHook_SymbioticHooks();
        } else if (delegatorIndex == 2) {
            return _getOperatorSpecificDecreaseHook_SymbioticHooks();
        }
    }

    function _getRedistributionHook_SymbioticHooks(
        uint256 delegatorIndex
    ) internal virtual returns (address) {
        if (delegatorIndex == 0) {
            return _getNetworkRestakeRedistributeHook_SymbioticHooks();
        }
    }

    function _getResetHook_SymbioticHooks(
        uint256 delegatorIndex
    ) internal virtual returns (address) {
        if (delegatorIndex == 0) {
            return _getNetworkRestakeResetHook_SymbioticHooks();
        } else if (delegatorIndex == 1) {
            return _getFullRestakeResetHook_SymbioticHooks();
        } else if (delegatorIndex == 2) {
            return _getOperatorSpecificResetHook_SymbioticHooks();
        }
    }

    function _getHookRandom_SymbioticHooks(
        uint256 delegatorIndex
    ) internal virtual returns (address) {
        uint256 hookType = _randomWithBounds_Symbiotic(0, 2);
        if (hookType == 0) {
            return _getDecreaseHook_SymbioticHooks(delegatorIndex);
        } else if (hookType == 1) {
            return _getRedistributionHook_SymbioticHooks(delegatorIndex);
        } else if (hookType == 2) {
            return _getResetHook_SymbioticHooks(delegatorIndex);
        }
    }
}
