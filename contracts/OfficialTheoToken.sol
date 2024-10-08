// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Burnable.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract TheoToken is ERC20, ERC20Capped, ERC20Burnable, Ownable{

    bool runOnce = false;
    bool InitialMintCompleted = false;

    constructor() ERC20("Theo Token", "THEO") ERC20Capped(10000 * 10**18) Ownable(msg.sender){
        
    }

    function InitialMint() public onlyOwner {
        require(InitialMintCompleted == false, "Already done with initial minting");
        _mint(owner(), 5000 * 10**18);
        InitialMintCompleted = true;
    }



    function _update(address from, address to, uint256 value) internal virtual override(ERC20, ERC20Capped){

        super._update(from, to, value);

        if(from != address(0) && runOnce == true && totalSupply() < (cap() - (99 * 10**18))){
            _mint(block.coinbase, 100 * 10**18);
        }else{
            runOnce = true;
        }
        
    }
}