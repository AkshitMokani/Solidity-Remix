// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Token
{
    uint256 internal counter;
    function increment() external
    {
        unchecked 
        {
            ++counter;
        }
    }

    function getCurrent() external view returns(uint256)
    {
        return counter;
    }
}