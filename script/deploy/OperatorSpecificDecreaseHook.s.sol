// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.25;

import {Script, console2} from "forge-std/Script.sol";

import {OperatorSpecificDecreaseHook} from "../../src/contracts/operatorSpecificDelegator/operatorSpecificDecreaseHook.sol";

contract OperatorSpecificDecreaseHookScript is Script {
    function run() public {
        vm.startBroadcast();

        address operatorSpecificDecreaseHook = address(new OperatorSpecificDecreaseHook());

        console2.log("OperatorSpecificDecreaseHook: ", operatorSpecificDecreaseHook);

        vm.stopBroadcast();
    }
}
