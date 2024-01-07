// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Commutr} from "../src/Commutr.sol";

contract CommutrTest is Test {
    Commutr bike;

    function setUp() public {
        bike = new Commutr();
    }

    function testName() public {
        assertEq(bike.name(), "Commutr");
    }

    function testSymbol() public {
        assertEq(bike.symbol(), "BIKE");
    }

    function testMint() public {
        bike.mint(address(1), 0, 1, "");
        assertEq(bike.balanceOf(address(1), 0), 1);
        bike.mint(address(1), 1, 100, "");
        assertEq(bike.balanceOf(address(1), 1), 100);
    }

    function testMintByUnapprovedAddresses(address notOwner) public {
        // address owner = bike.owner();
        vm.assume(notOwner != bike.owner());
        vm.prank(notOwner);
        vm.expectRevert();
        bike.mint(address(1), 0, 1, "");
    }

    function testMintBatch() public {
        uint256[] memory ids = new uint256[](2);
        ids[0] = 0;
        ids[1] = 1;
        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 1;
        amounts[1] = 100;
        address[] memory addresses = new address[](2);
        addresses[0] = address(1);
        addresses[1] = address(1);
        bike.mintBatch(address(1), ids, amounts, "");
        assertEq(bike.balanceOfBatch(addresses, ids), amounts);
    }

    function testSetUri() public {
        string memory current_uri = bike.uri(1);
        assertEq(current_uri, "https://commutr.xyz/{id}.json");
        bike.setURI("test_domain_{id}");
        assertEq(bike.uri(1), "test_domain_{id}", "Expect the url has changed to test_domain_{id}");
    }
}
