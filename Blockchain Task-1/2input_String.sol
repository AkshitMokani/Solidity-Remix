// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SetValue {
    string public value;
    address public owner;

    constructor()
    {
        owner=msg.sender;
    }

    // modifier onlyOwner() {
    //     require(owner == msg.sender,"Only Owner can call this function");
    //     _;
    // }

    function setValue(string memory _value) public {
        require(msg.sender == owner,"Only Owner can call this function");
        value = _value;
    }
}
