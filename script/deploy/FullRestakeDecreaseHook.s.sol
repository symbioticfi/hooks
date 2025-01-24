// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.25;

import {Script, console2} from "forge-std/Script.sol";

import {FullRestakeDecreaseHook} from "../../src/contracts/fullRestakeDelegator/FullRestakeDecreaseHook.sol";

contract FullRestakeDecreaseHookScript is Script {
    function run() public {
        vm.startBroadcast();

        address fullRestakeDecreaseHook = address(new FullRestakeDecreaseHook());

        console2.log("FullRestakeDecreaseHook: ", fullRestakeDecreaseHook);

        vm.stopBroadcast();
    }
}
