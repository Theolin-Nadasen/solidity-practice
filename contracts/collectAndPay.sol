// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract recieceAndPay{
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function GiveMoney() public payable {
        require(msg.value > 200 gwei, "too little sent");
    }

    modifier OnlyOwner(){
        require(msg.sender == owner);
        _;
    }

    function payout() public OnlyOwner{
        uint256 balance = address(this).balance;
        owner.transfer(balance);
    }
}