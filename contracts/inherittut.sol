// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.20;

contract InheritTut is Ownable(msg.sender) {
    

    function getanumber() public view onlyOwner returns (uint256){
        uint256 num = 5;

        return num;
    }
}