// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import { SimpleStorage } from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {

    // override modifier gives us the ability to override the store function from SimpleStorage
    function store(uint256 _newNumber) public override {
        myFavouriteNumber = _newNumber + 5;
    }

    // Is is pure, because it doesn't read a state variable
    function sayHello() public pure returns (string memory) {
        return "Hello";
    }
}