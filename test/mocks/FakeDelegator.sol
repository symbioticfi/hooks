// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {IDelegatorHook} from "@symbioticfi/core/src/interfaces/delegator/IDelegatorHook.sol";

contract FakeDelegator {
    address public vault;

    uint64 public TYPE;

    constructor(address vault_, uint64 type_) {
        vault = vault_;

        TYPE = type_;
    }

    function onSlash(
        address target,
        bytes32 subnetwork,
        address operator,
        uint256 slashedAmount,
        uint48 captureTimestamp,
        bytes calldata data
    ) external {
        IDelegatorHook(target).onSlash(subnetwork, operator, slashedAmount, captureTimestamp, data);
    }
}
