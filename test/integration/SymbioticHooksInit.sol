// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@symbioticfi/core/test/integration/SymbioticCoreInit.sol";

import "./SymbioticHooksImports.sol";

import {SymbioticHooksConstants} from "./SymbioticHooksConstants.sol";
import {SymbioticHooksBindings} from "./SymbioticHooksBindings.sol";
import {SymbioticHooksBytecode} from "./SymbioticHooksBytecode.sol";

import {SafeERC20, IERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {Create2} from "@openzeppelin/contracts/utils/Create2.sol";

contract SymbioticHooksInit is SymbioticCoreInit, SymbioticHooksBindings {
    using SafeERC20 for IERC20;
    using Math for uint256;

    // General config

    string public SYMBIOTIC_HOOKS_PROJECT_ROOT = "";

    function setUp() public virtual override {
        SymbioticCoreInit.setUp();
    }

    // ------------------------------------------------------------ HOOKS-RELATED HELPERS ------------------------------------------------------------ //

    function _getNetworkRestakeDecreaseHook_SymbioticHooks(bool useExisting) internal virtual returns (address) {
        if (useExisting) {
            return SymbioticHooksConstants.networkRestakeDecreaseHook();
        }

        bytes memory constructorArgs;

        return _deployHook(
            bytes32("networkRestakeDecreaseHook"), SymbioticHooksBytecode.networkRestakeDecreaseHook(), constructorArgs
        );
    }

    function _getNetworkRestakeRedistributeHook_SymbioticHooks(bool useExisting) internal virtual returns (address) {
        if (useExisting) {
            return SymbioticHooksConstants.networkRestakeRedistributeHook();
        }

        bytes memory constructorArgs;

        return _deployHook(
            bytes32("networkRestakeRedistributeHook"),
            SymbioticHooksBytecode.networkRestakeRedistributeHook(),
            constructorArgs
        );
    }

    function _getNetworkRestakeResetHook_SymbioticHooks(uint48 period, uint256 slashCount)
        internal
        virtual
        returns (address)
    {
        bytes memory constructorArgs = abi.encode(period, slashCount);

        return _deployHook(
            bytes32("networkRestakeResetHook"), SymbioticHooksBytecode.networkRestakeResetHook(), constructorArgs
        );
    }

    function _getNetworkRestakeResetHook_SymbioticHooks() internal virtual returns (address) {
        return _getNetworkRestakeResetHook_SymbioticHooks(7 days, 3);
    }

    function _getFullRestakeDecreaseHook_SymbioticHooks(bool useExisting) internal virtual returns (address) {
        if (useExisting) {
            return SymbioticHooksConstants.fullRestakeDecreaseHook();
        }

        bytes memory constructorArgs;

        return _deployHook(
            bytes32("fullRestakeDecreaseHook"), SymbioticHooksBytecode.fullRestakeDecreaseHook(), constructorArgs
        );
    }

    function _getFullRestakeResetHook_SymbioticHooks(uint48 period, uint256 slashCount)
        internal
        virtual
        returns (address)
    {
        bytes memory constructorArgs = abi.encode(period, slashCount);

        return
            _deployHook(bytes32("fullRestakeResetHook"), SymbioticHooksBytecode.fullRestakeResetHook(), constructorArgs);
    }

    function _getFullRestakeResetHook_SymbioticHooks() internal virtual returns (address) {
        return _getFullRestakeResetHook_SymbioticHooks(7 days, 3);
    }

    function _getOperatorSpecificDecreaseHook_SymbioticHooks(bool useExisting) internal virtual returns (address) {
        if (useExisting) {
            return SymbioticHooksConstants.operatorSpecificDecreaseHook();
        }

        bytes memory constructorArgs;

        return _deployHook(
            bytes32("operatorSpecificDecreaseHook"),
            SymbioticHooksBytecode.operatorSpecificDecreaseHook(),
            constructorArgs
        );
    }

    function _getOperatorSpecificResetHook_SymbioticHooks(uint48 period, uint256 slashCount)
        internal
        virtual
        returns (address)
    {
        bytes memory constructorArgs = abi.encode(period, slashCount);

        return _deployHook(
            bytes32("operatorSpecificResetHook"), SymbioticHooksBytecode.operatorSpecificResetHook(), constructorArgs
        );
    }

    function _getOperatorSpecificResetHook_SymbioticHooks() internal virtual returns (address) {
        return _getOperatorSpecificResetHook_SymbioticHooks(7 days, 3);
    }

    function _getDecreaseHook_SymbioticHooks(bool useExisting, uint256 delegatorIndex)
        internal
        virtual
        returns (address)
    {
        if (delegatorIndex == 0) {
            return _getNetworkRestakeDecreaseHook_SymbioticHooks(useExisting);
        } else if (delegatorIndex == 1) {
            return _getFullRestakeDecreaseHook_SymbioticHooks(useExisting);
        } else if (delegatorIndex == 2) {
            return _getOperatorSpecificDecreaseHook_SymbioticHooks(useExisting);
        }
    }

    function _getRedistributionHook_SymbioticHooks(bool useExisting, uint256 delegatorIndex)
        internal
        virtual
        returns (address)
    {
        if (delegatorIndex == 0) {
            return _getNetworkRestakeRedistributeHook_SymbioticHooks(useExisting);
        }
    }

    function _getResetHook_SymbioticHooks(uint256 delegatorIndex) internal virtual returns (address) {
        if (delegatorIndex == 0) {
            return _getNetworkRestakeResetHook_SymbioticHooks();
        } else if (delegatorIndex == 1) {
            return _getFullRestakeResetHook_SymbioticHooks();
        } else if (delegatorIndex == 2) {
            return _getOperatorSpecificResetHook_SymbioticHooks();
        }
    }

    function _getHookRandom_SymbioticHooks(uint256 delegatorIndex) internal virtual returns (address) {
        uint256 hookType = _randomWithBounds_Symbiotic(0, 2);
        if (hookType == 0) {
            return _getDecreaseHook_SymbioticHooks(false, delegatorIndex);
        } else if (hookType == 1) {
            return _getRedistributionHook_SymbioticHooks(false, delegatorIndex);
        } else if (hookType == 2) {
            return _getResetHook_SymbioticHooks(delegatorIndex);
        }
    }

    function _deployHook(bytes32 salt, bytes memory baseCode, bytes memory constructorArgs)
        internal
        returns (address deployed)
    {
        bytes32 bytecodeHash = keccak256(bytes.concat(baseCode, constructorArgs));
        address predicted = Create2.computeAddress(salt, bytecodeHash);
        if (predicted.code.length > 0) {
            return predicted;
        }

        return _deployCreate2(salt, baseCode, constructorArgs);
    }
}
