// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract  local
{
    function store() pure public returns(uint, string memory)
    {
        string memory name="solidity";
        uint age = 20;
        return (age, name);
    }

    function returnValues() public view returns(uint, string memory)
    {
        return(20,"Hi");
    }
}