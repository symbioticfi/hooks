// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.25;

import {Script, console2} from "forge-std/Script.sol";

import {FullRestakeResetHook} from "../../src/contracts/FullRestakeDelegator/FullRestakeResetHook.sol";

contract FullRestakeResetHookScript is Script {
    function run(uint48 period, uint256 slashCount) public {
        vm.startBroadcast();

        address fullRestakeResetHook = address(new FullRestakeResetHook(period, slashCount));

        console2.log("FullRestakeResetHook: ", fullRestakeResetHook);

        vm.stopBroadcast();
    }
}
