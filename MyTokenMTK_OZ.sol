// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyTokenMTK_OZ is ERC20
{
    // constructor(uint amt) ERC20("My Token","MTK")  //Initial Supply
    // {
    //     _mint(msg.sender,amt);
    // }

    constructor() ERC20("My Token","MTK")             //Fixed Supply
    {
        _mint(msg.sender,1000*10**18);
    }
}