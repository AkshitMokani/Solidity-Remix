// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract fallback_receive
{
    event log(string _fun,address _sender,uint val,bytes _data);

    // fallback() external payable
    // {
    //     emit log("fallback",msg.sender,msg.value,msg.data);
    // }

    // receive() external payable
    // {
    //     emit log("receive",msg.sender,msg.value,"");
    // }

    function getBalance() public view returns(uint)
    {
        return address(this).balance;
    }

    // function deposit() public payable
    // {
    //     uint amount=msg.value;
    //     payable(address(this)).transfer(amount);
    // }

    receive() external payable{}
    
    function sendEther(uint amount) public payable 
    {
        amount = msg.value;
        payable(address(this)).transfer(amount);
    }

}