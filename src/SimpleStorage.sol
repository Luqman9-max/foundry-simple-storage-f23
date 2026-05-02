// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleStorage {
    /* ERRORS */
    error NameEmpty();
    error NumberInvalid();
    error AgeInvalid();
    error PersonNotFound();

    uint256 private myFavoriteNumber;

    struct Person {
        uint256 age;
        string name;
        uint256 favoriteNumber;
    }

    Person[] private listOfPeople;

    mapping(string => uint256) private nameToIndex; // simpan index + 1
    mapping(string => bool) private personExists;

    /* CORE */
    function store(uint256 _favoriteNumber) public {
        if (_favoriteNumber == 0) revert NumberInvalid();
        myFavoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return myFavoriteNumber;
    }

    /* CREATE */
    function addPerson(
        uint256 _age,
        string calldata _name,
        uint256 _favoriteNumber
    ) external {
        if (_age == 0) revert AgeInvalid();
        if (bytes(_name).length == 0) revert NameEmpty();
        if (_favoriteNumber == 0) revert NumberInvalid();

        listOfPeople.push(Person(_age, _name, _favoriteNumber));

        nameToIndex[_name] = listOfPeople.length; // index + 1
        personExists[_name] = true;
    }

    /* READ */
    function getPersonByName(
        string calldata _name
    ) external view returns (Person memory) {
        if (!personExists[_name]) revert PersonNotFound();

        uint256 index = nameToIndex[_name] - 1;
        return listOfPeople[index];
    }

    function getPerson(uint256 index) external view returns (Person memory) {
        return listOfPeople[index];
    }

    function getAllPeople() external view returns (Person[] memory) {
        return listOfPeople;
    }

    function totalPeople() external view returns (uint256) {
        return listOfPeople.length;
    }

    /* UPDATE */
    function updatePerson(
        string calldata _name,
        uint256 _newAge,
        uint256 _newFavoriteNumber
    ) external {
        if (!personExists[_name]) revert PersonNotFound();
        if (_newAge == 0) revert AgeInvalid();
        if (_newFavoriteNumber == 0) revert NumberInvalid();

        uint256 index = nameToIndex[_name] - 1;

        listOfPeople[index].age = _newAge;
        listOfPeople[index].favoriteNumber = _newFavoriteNumber;
    }

    /* DELETE, tetap ada tapi kosong (gunakan swap & pop lebih baik) */
    function deletePerson(string calldata _name) external {
        if (!personExists[_name]) revert PersonNotFound();

        uint256 index = nameToIndex[_name] - 1;

        delete listOfPeople[index]; // sederhana (tidak hemat gas)

        delete nameToIndex[_name];
        delete personExists[_name];
    }
}
