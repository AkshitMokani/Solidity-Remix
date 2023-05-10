// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract mappingbook
{
    mapping(uint => string) public book;

    function addbook(uint book_Id,string memory author_name) public 
    {
        book[book_Id]=author_name;
    }

    function getbook(uint book_Id) public view returns(string memory)
    {
        return book[book_Id];
    }

    function deletebook(uint book_Id) public 
    {
        delete book[book_Id];
    }
}