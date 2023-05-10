// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Array
{
    bytes1 public b1;
    bytes2 public b2;
    bytes3 public b3;
    bytes32 public b32;

    function setter() public
    {
        b1='Z';
        b2='3';
        b3='4Z ';
        b32='iehbeck';
    }
    function len() public view returns(uint)
    {
        return b1.length;
    }
    function getel(uint i,uint j) public view returns(bytes1,bytes1)
    {
        return (b3[i],b3[j]);
    }
}

