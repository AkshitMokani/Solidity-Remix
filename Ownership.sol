// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Ownership
{
    address owner;
    address oldOwner;

    constructor()
    {
        owner=msg.sender;
    }

    event log(string str,address adr,string str1,address adr1);

    function changeOwner(address newOwner) public
    {
        require(msg.sender == owner, "Only Owner can access");
        oldOwner=owner; //store the old owner value
        owner=newOwner;
        emit log("Old Owner",oldOwner,"New Owner",newOwner);
    }

    function viewOwner() public view returns(address)
    {
        return owner;
    }

}