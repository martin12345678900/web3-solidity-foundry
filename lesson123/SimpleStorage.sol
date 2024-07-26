// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;


contract SimpleStorage {


    uint256 myFavouriteNumber; // 0 as default
 
    struct Person {
        uint256 favouriteNumber;
        string name;
    }

    // dynamic array
    Person[] public listOfPeople; // [] as default

    mapping(string => uint256) public nameToFavouriteNumber;

    // virtual modifier gives the oppurtunity other contacts that inherit the SimpleStorage to override it
    function store(uint256 _favouriteNumber) public virtual {
        myFavouriteNumber = _favouriteNumber;
    }

    // "view" means it is reading a state variable inside the function (can't update a state variable)
    // "pure" means it cannot neither read or update a state variable
    function retrieve() public view returns(uint256) {
        return myFavouriteNumber;
    }
    
    // memory is appliable only for special types (string, array, mapping)
    // memory is temporary variable which is not available after the function execution
    // differnce between memory and calldata is memory variables can be reassigned as long as calldata ones - no
    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        Person memory newPerson = Person(_favouriteNumber, _name);
        listOfPeople.push(newPerson);

        nameToFavouriteNumber[_name] = _favouriteNumber;
    }
}