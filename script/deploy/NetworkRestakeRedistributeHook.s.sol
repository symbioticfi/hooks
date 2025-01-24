// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.25;

import {Script, console2} from "forge-std/Script.sol";

import {NetworkRestakeRedistributeHook} from
    "../../src/contracts/networkRestakeDelegator/NetworkRestakeRedistributeHook.sol";

contract NetworkRestakeRedistributeHookScript is Script {
    function run() public {
        vm.startBroadcast();

        address networkRestakeRedistributeHook = address(new NetworkRestakeRedistributeHook());

        console2.log("NetworkRestakeRedistributeHook: ", networkRestakeRedistributeHook);

        vm.stopBroadcast();
    }
}
