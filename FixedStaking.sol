// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzepplin/contracts/token/ERC20/ERC20.sol";

contract FixedStaking is ERC20
{

    mapping(address => uint) public staked;
    mapping(address => uint) public stakedFromTS; //TimeStamp

    constructor() ERC20("Fixed Staking", "FIX")
    {
        _mint(msg.sender,1000000000000000000);
    }
}