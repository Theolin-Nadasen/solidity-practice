// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Capped.sol";

contract Token is ERC20, ERC20Capped{

    address payable public owner;
    bool runOnce = false;

    constructor() ERC20("Miner", "MINE") ERC20Capped(100000 * 10**18) {
        owner = payable(msg.sender);
        _mint(owner, 50000 * 10**18);
    }

    function _update(address from, address to, uint256 value) internal virtual override(ERC20, ERC20Capped){

        super._update(from, to, value);

        if(from != address(0) && runOnce == true && totalSupply() < (cap() - (100 * 10**18))){
            _mint(block.coinbase, 100 * 10**18);
        }else{
            runOnce = true;
        }
        
    }

    function MintSome() public{
        _mint(msg.sender, 10000 * 10 ** 18);
    }

}