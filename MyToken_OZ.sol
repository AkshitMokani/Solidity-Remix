// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken_OZ is ERC20
{

    constructor () ERC20("Sol Will be Zero", "SolZero") 
    {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}