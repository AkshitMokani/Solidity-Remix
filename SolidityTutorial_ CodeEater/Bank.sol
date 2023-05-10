pragma solidity ^0.8.17;
// SPDX-License-Identifier: MIT

contract Bank
{
    int Bal;

    constructor() public
    {
        Bal = 1;
    }

    function getBalance() view public returns(int)
    {
        return Bal;
    }

    function Deposit(int amt) public 
    {
        Bal = Bal + amt;
    }

    function Withdraw(int amt) public
    {
        Bal = Bal - amt;
    }
}