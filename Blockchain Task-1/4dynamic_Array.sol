// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract dynamic_Array
{
    string[] public country;

    function addCountry(string memory country_name) public
    {
        country.push(country_name);
    }

    function removeCountry() public
    {
        country.pop();
    }

    function totalCountry() public view returns(uint)
    {
        return country.length;
    }

    function allCountry() public view returns(string[] memory)
    {
        return country;
    }
}

