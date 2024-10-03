// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract eventExample{

    event NewUserRegistered(address indexed user, string username);

    struct user{
        string name;
        uint256 age;
    }

    mapping (address => user) public users;

    function registerUser(string memory _name, uint256 _age) public {
        user storage newUser = users[msg.sender];
        newUser.name = _name;
        newUser.age = _age;

        emit NewUserRegistered(msg.sender, _name);
    }
}