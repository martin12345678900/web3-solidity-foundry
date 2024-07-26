// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { SimpleStorage } from "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public listOfSimpleStorageContracts;

    function createSimpleStorageContact() public {
        SimpleStorage newSimpleStorageContact = new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorageContact);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public  {
        // Address
        // ABI - Application Binary Interface
        SimpleStorage currentSimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];

        currentSimpleStorage.store(_simpleStorageNumber);
    }
    
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        SimpleStorage currentSimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];

        uint256 favouriteNumber = currentSimpleStorage.retrieve();

        return favouriteNumber;
    }
}