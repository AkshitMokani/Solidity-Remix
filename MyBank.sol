// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Deposit 
{
    //mapping(address=> uint ) private _balances;
    address public owner;


    constructor() 
    {
        owner = msg.sender;
    }

    function deposit(uint amt) public payable 
    {
        payable (owner).transfer(amt);
        
    }

    // function deposite() public payable  returns (uint)
    //     {

    //     require ((_balances[msg.sender] + msg.value) >  _balances[msg.sender] && msg.sender!=address(0));
    //     _balances[msg.sender] = msg.value;
    //     //emit LogDepositeMade(msg.sender , msg.value);
    //     return _balances[msg.sender];
    //     } 


    function viewBal() public view returns(uint,uint)
    {
        return (address(this).balance , owner.balance);
    }
}
