// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@symbioticfi/core/test/integration/SymbioticCoreIntegration.sol";

import "./SymbioticHooksInit.sol";

contract SymbioticHooksIntegration is SymbioticHooksInit, SymbioticCoreIntegration {
    function setUp() public virtual override(SymbioticHooksInit, SymbioticCoreIntegration) {
        SymbioticCoreIntegration.setUp();
    }

    function _getVaultRandom_SymbioticCore(
        address[] memory operators,
        address collateral
    ) internal virtual override returns (address) {
        uint48 epochDuration =
            uint48(_randomWithBounds_Symbiotic(SYMBIOTIC_CORE_MIN_EPOCH_DURATION, SYMBIOTIC_CORE_MAX_EPOCH_DURATION));
        uint48 vetoDuration = uint48(
            _randomWithBounds_Symbiotic(
                SYMBIOTIC_CORE_MIN_VETO_DURATION, Math.min(SYMBIOTIC_CORE_MAX_VETO_DURATION, epochDuration / 2)
            )
        );

        uint256 count_ = 0;
        uint64[] memory delegatorTypes = new uint64[](SYMBIOTIC_CORE_DELEGATOR_TYPES);
        for (uint64 i; i < SYMBIOTIC_CORE_DELEGATOR_TYPES; ++i) {
            if (operators.length == 0 && i == 2) {
                continue;
            }
            delegatorTypes[i] = i;
            ++count_;
        }
        assembly ("memory-safe") {
            mstore(delegatorTypes, count_)
        }
        uint64 delegatorIndex = _randomPick_Symbiotic(delegatorTypes);

        count_ = 0;
        uint64[] memory slasherTypes = new uint64[](SYMBIOTIC_CORE_SLASHER_TYPES);
        for (uint64 i; i < SYMBIOTIC_CORE_SLASHER_TYPES; ++i) {
            if (false) {
                continue;
            }
            slasherTypes[i] = i;
            ++count_;
        }
        assembly ("memory-safe") {
            mstore(slasherTypes, count_)
        }
        uint64 slasherIndex = _randomPick_Symbiotic(slasherTypes);

        // New code
        address hook = _getHookRandom_SymbioticHooks(delegatorIndex);

        return _getVault_SymbioticCore(
            operators.length == 0 ? address(this) : _randomPick_Symbiotic(operators),
            collateral,
            0x000000000000000000000000000000000000dEaD,
            epochDuration,
            new address[](0),
            0,
            delegatorIndex,
            hook,
            true,
            slasherIndex,
            vetoDuration
        );
    }
}
