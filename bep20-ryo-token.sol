//I want to create a token using BEP-20 standard

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Commencing with the smart contract -->
contract Token {
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    uint public totalSupply = 10000 * 10**18;
    string public name = "RYO Token";
    string public symbol = "RYO";
    uint public decimals = 18;

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    constructor() {
        balances[msg.sender] = totalSupply;
    }

    //This modifier helps to check for amount validity
    modifier validAmount(address account, uint value) {
        require(balanceOf(account) >= value, "balance too low");
        _;
    }

    //This function helps to checking wallet balance
    function balanceOf(address owner) public view returns (uint) {
        return balances[owner];
    }

    //This function helps to transfer function
    function transfer(address to, uint value)
        public
        validAmount(msg.sender, value)
        returns (bool)
    {
        //require(balanceOf(msg.sender) >= value, "balance too low");
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    //This function helps for transfer from function
    function transferFrom(
        address from,
        address to,
        uint value
    ) public validAmount(from, value) returns (bool) {
        require(allowance[from][msg.sender] >= value, "allowance too low");
        balances[to] += value;
        balances[from] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    //This function approves a spender
    function approve(address spender, uint value) public returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}
