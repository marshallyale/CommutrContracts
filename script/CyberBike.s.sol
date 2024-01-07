// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Commutr} from "../src/Commutr.sol";

contract CommutrScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        Commutr commutr = new Commutr();
        vm.stopBroadcast();
    }
}
