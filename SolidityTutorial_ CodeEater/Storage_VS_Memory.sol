// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Storage_VS_Memory
{
    string[] public student=["A","B","C"];

    function memry() public view
    {
        string[] memory s1=student;
        s1[0]="AA";
    }

    function storge() public
    {
        string[] storage s1=student;
        s1[0]="AA";
    }
}