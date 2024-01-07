// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {Strings} from "openzeppelin/utils/Strings.sol";
import {Simple} from "../src/Simple.sol";

contract SimpleTest is Test {
    using Strings for uint256;

    Simple public simple;

    function setUp() public {
        simple = new Simple(0);
    }

    function test_OnlyOwner(address _hacker) public {
        vm.assume(_hacker != address(this));
        vm.prank(_hacker);
        vm.expectRevert("Ownable: caller is not the owner");
        simple.setValue(0);
    }

    function testFuzz_SetValue(uint256 x) public {
        simple.setValue(x);
        assertEq(simple.getValue(), x.toString());
    }
}
