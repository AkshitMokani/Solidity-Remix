// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Array
{
    uint[] public arr;

    function pushelement(uint item) public
    {
        arr.push(item);
    }

    function length() public view returns(uint)
    {
        return arr.length;
    }

    function popelement() public
    {
        arr.pop();
    }

}