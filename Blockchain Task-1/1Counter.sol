// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract counter
{
    uint public count = 4;
    uint newValue;
    //event incrementc(string str,uint count,string str1,uint newValue);
    event incrementc(uint oldVlaue,uint newValue);

    function increment() public returns(uint)
    {
        count=count+5;   
        emit incrementc(count-5,count);
        return count;
    }


    //event decrementc(uint newCount);

    // function Increment() public returns(uint)
    // {
    //     newValue = count + 5;
    //     emit incrementc("Old Value is : ",count,"New Value is:",newValue);
    //     return count;
    // }

    // function Decrement() public returns(uint)
    // {
    //     count = count - 2;
    //     emit incrementc("Old Value is : ",count,"New Value is:",newValue);
    //     return count;
    // }
}