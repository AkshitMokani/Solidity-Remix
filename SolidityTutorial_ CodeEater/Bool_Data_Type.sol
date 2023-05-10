// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Bool_Data_Type
{
    bool public value; //By default value false

    function check(uint a) public returns(bool)
    {
        if(a>100)
        {
            value=true;
            return value;
        }
        else
        {
            value=false;
            return value;
        }
    }
}