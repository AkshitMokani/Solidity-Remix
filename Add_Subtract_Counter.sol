// SPDX-License-Identifier: MIT

// CRUD operations  (C=Create R=Read U=Update D=Delete)
pragma solidity ^0.8.4;

contract Add_Subtract_Counter
{
    uint256 public coins;

    function Add() public
    {
        coins++;
    }
    function Subtract() public
    {
        coins--;
    }
    function Set(uint256 coin) public
    {
        coins = coin;
    }
}