// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract if_else
{
    function check(int a) public pure returns(string memory)
    {
        string memory value;

        if(a>0)
        {
            value="Entered Value is greater than Zero";
        }
        else if(a==0)
        {
            value="Entered Value is Zero";
        }
        else
        {
            value="Entered Value is not greater than Zero";
        }

        return value;
    }
}