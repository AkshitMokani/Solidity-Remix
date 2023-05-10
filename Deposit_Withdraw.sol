// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Deposit_Withdraw
{

    address public owner;
    address[] public DepositAddressList;
    address[] public WithdrawAddressList;

    mapping(address => uint) public TotalDepAmt;
    mapping(address => uint) public TotalWidAmt;

    constructor()
    {
        owner=msg.sender;
    }

    function deposit() public payable
    {
        require(msg.value > 0,"Please check entered value");
        // require(msg.sender == owner,"Only Owner can call this function");
        DepositAddressList.push(msg.sender);   //add the sender address in list/array
        TotalDepAmt[msg.sender]+=msg.value; 
        // map the address with sent ether and give the total value of ether from the entered address 
    }

    function withdraw(uint amt) public payable
    {
        //call method: (forward all gas or set gas, return bool)  //RECOMMENDED
        (bool callSuccess,) = payable(msg.sender).call{value:amt}("");
        //(bool callSuccess,) = payable(msg.sender).call{value:address(this).balance}(""); //it withdraws entire balance.
        require(callSuccess,"My call failed");

        //transfer - there is a preset 2300 Gas cap, errors out  when this is not met
        payable(msg.sender).transfer(amt);

        //send - there is a preset 2300 Gas cap, returns the booleon with the message
        bool message = payable(msg.sender).send(amt);
        require (message,"Failed");

        WithdrawAddressList.push(msg.sender);
        TotalWidAmt[msg.sender]+=amt;

    }


    function viewBal() public view returns(uint,uint)
    {
        return ((address(this)).balance , owner.balance);
    }

    function checkBalance(address addr) public view returns(uint)
    {
        return addr.balance;
    }

}