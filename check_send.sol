// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract check_send
{
    address public owner;

    constructor()
    {
        owner=msg.sender;
    }

    function deposit() public payable
    {
        require(msg.value > 0,"Please check entered amount");
    }

    function transfer(address payable adrs, uint amt) public payable
    {
        amt = msg.value;
        adrs.transfer(amt);
    }

    function withdraw(uint amt) public 
    {
        payable(msg.sender).transfer(amt);
    }

    function checkBal() public view returns(uint)
    {        
        return (address(this).balance);
    }
    function checkBalance(address addr) public view returns(uint)
    {
        return addr.balance;
    }

}