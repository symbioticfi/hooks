// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.25;

import {Script, console2} from "forge-std/Script.sol";

import {FullRestakeDecreaseHook} from "../../src/contracts/fullRestakeDelegator/FullRestakeDecreaseHook.sol";
import {NetworkRestakeDecreaseHook} from "../../src/contracts/networkRestakeDelegator/NetworkRestakeDecreaseHook.sol";
import {NetworkRestakeRedistributeHook} from
    "../../src/contracts/networkRestakeDelegator/NetworkRestakeRedistributeHook.sol";
import {OperatorSpecificDecreaseHook} from
    "../../src/contracts/operatorSpecificDelegator/OperatorSpecificDecreaseHook.sol";

contract HooksScript is Script {
    function run() public {
        vm.startBroadcast();

        address fullRestakeDecreaseHook = address(new FullRestakeDecreaseHook());
        address networkRestakeDecreaseHook = address(new NetworkRestakeDecreaseHook());
        address networkRestakeRedistributeHook = address(new NetworkRestakeRedistributeHook());
        address operatorSpecificDecreaseHook = address(new OperatorSpecificDecreaseHook());

        console2.log("FullRestakeDecreaseHook: ", fullRestakeDecreaseHook);
        console2.log("NetworkRestakeDecreaseHook: ", networkRestakeDecreaseHook);
        console2.log("NetworkRestakeRedistributeHook: ", networkRestakeRedistributeHook);
        console2.log("OperatorSpecificDecreaseHook: ", operatorSpecificDecreaseHook);

        vm.stopBroadcast();
    }
}
