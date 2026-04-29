// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleStorage {
    uint256 myFavoriteNumber;

    function store (uint256 _newFavoriteNumber) public virtual {
        myFavoriteNumber = _newFavoriteNumber;
    }

    function retrieve () public view returns (uint256){
        return myFavoriteNumber;
    }

    mapping (string => uint256) public searchFavoriteNumber;
    
    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    Person[] public listOfPeople;

    function addNewPerson (string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person({favoriteNumber: _favoriteNumber, name: _name}));
        searchFavoriteNumber[_name] = _favoriteNumber;
    }
}
