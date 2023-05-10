// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract constructor2
{
    uint public count;

    constructor(uint new_count) //pass the value at the time of deploy. 
    { 
        count=new_count;
    } 

    function setter(uint count1) view public returns(uint)
    {
        count1=count+count1;
        return count1;
    }
}