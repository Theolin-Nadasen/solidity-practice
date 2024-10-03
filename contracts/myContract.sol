// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


contract Ownable{
    address owner;

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }
}


contract secretVault{
    string secret;

    constructor(string memory _secret) {
        secret = _secret;
    }

    function getSecret()public view returns(string memory){
        return secret;
    }
}


contract myContract is Ownable{

    string secret;
    address SecretVault;

    constructor(string memory _secret){
        secretVault _secretvault = new secretVault(_secret);

        SecretVault = address(_secretvault);

        super;
    }

    function getSecret()public view onlyOwner returns(string memory){
        return secretVault(SecretVault).getSecret();
    }

}