// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract HotelRoom{
    address payable public owner;

    enum RoomStates {Occupied, Vacant}
    RoomStates public currentState;

    event Occupy(address _occupant, uint value);

    constructor(){
        owner = payable(msg.sender);
        currentState = RoomStates.Vacant;
    }

    modifier onlyWhileVacant(){
        require(currentState == RoomStates.Vacant, "room is not empty!");
        _;
    }

    modifier payed(uint _amt){
        require(msg.value >= _amt, "not enough ether paid");
        _;
    }

    function book() public payable onlyWhileVacant payed(2 ether){
        currentState = RoomStates.Occupied;

        (bool sent, bytes memory data ) = owner.call{value : msg.value}("");
        require(sent == true);

        emit Occupy(msg.sender, msg.value);
    }

}