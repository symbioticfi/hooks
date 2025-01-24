// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.25;

import {Script, console2} from "forge-std/Script.sol";

import {NetworkRestakeResetHook} from "../../src/contracts/NetworkRestakeDelegator/NetworkRestakeResetHook.sol";

contract NetworkRestakeResetHookScript is Script {
    function run(uint48 period, uint256 slashCount) public {
        vm.startBroadcast();

        address networkRestakeResetHook = address(new NetworkRestakeResetHook(period, slashCount));

        console2.log("NetworkRestakeResetHook: ", networkRestakeResetHook);

        vm.stopBroadcast();
    }
}
