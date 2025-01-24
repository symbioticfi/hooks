// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.25;

import {Script, console2} from "forge-std/Script.sol";

import {OperatorSpecificResetHook} from "../../src/contracts/operatorSpecificDelegator/OperatorSpecificResetHook.sol";

contract OperatorSpecificResetHookScript is Script {
    function run(uint48 period, uint256 slashCount) public {
        vm.startBroadcast();

        address operatorSpecificResetHook = address(new OperatorSpecificResetHook(period, slashCount));

        console2.log("OperatorSpecificResetHook: ", operatorSpecificResetHook);

        vm.stopBroadcast();
    }
}
