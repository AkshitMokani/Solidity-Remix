// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract myWallet
{
    address public owner;

    constructor()
    {
        owner=msg.sender;
    }

    

    function myBalance() public view returns(uint)
    {
        return owner.balance;
    }
}