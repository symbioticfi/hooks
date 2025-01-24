// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.25;

import {Script, console2} from "forge-std/Script.sol";

import {NetworkRestakeDecreaseHook} from "../../src/contracts/networkRestakeDelegator/NetworkRestakeDecreaseHook.sol";

contract NetworkRestakeDecreaseHookScript is Script {
    function run() public {
        vm.startBroadcast();

        address networkRestakeDecreaseHook = address(new NetworkRestakeDecreaseHook());

        console2.log("NetworkRestakeDecreaseHook: ", networkRestakeDecreaseHook);

        vm.stopBroadcast();
    }
}
