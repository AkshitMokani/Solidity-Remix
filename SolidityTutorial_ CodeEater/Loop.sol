// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Loops
{
    uint[3] public arr;
    uint public count;

    function whileLoop() public
    {
        while(count<arr.length)
        {
            arr[count]=count+1;
            count++;
        }
    }
    function forLoop() public
    {
        for(count=1;count<=arr.length;count++)
        {
            arr[count-1]=count;
        }
    }
    function dowhileLoop() public
    {
        do
        {
            arr[count]=count*2;
            count++;
        }
        while(count<arr.length);
    }
}