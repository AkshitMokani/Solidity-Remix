// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Function1
{
    uint age = 20;

    function getter() view public returns(uint)
    {
        return age;
    }

    function setter(uint age) view public returns(uint)
    {
        age=20;
        age=age+1;
        return age;
    }

    function update(uint newage) public
    {
        age=newage;
    }
}


