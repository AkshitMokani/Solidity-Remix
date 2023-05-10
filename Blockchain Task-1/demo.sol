// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Counter {
    uint private count = 4;
    event Incremented(uint amount, uint newCount);
    event Decremented(uint amount, uint newCount);

    function increment() public {
        count += 5;
        emit Incremented(5, count);
    }

    function decrement() public {
        count -= 2;
        emit Decremented(2, count);
    }

    function getCount() public view returns (uint) {
        return count;
    }
}