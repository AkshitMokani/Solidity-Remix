// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Array
{
    bytes public b1="abc";

    function pushelement() public
    {
        b1.push('d');
    }
    function pushelement1(bytes1 value) public
    {
        b1[0] = value;
    }
    function pushelement2(bytes1 k) public
    {
        b1.push(k);
    }
    function getelement(uint i) public view returns(bytes1)
    {
        return b1[i];
    }
    function length() public view returns(uint) 
    {
        return b1.length;
    }
}