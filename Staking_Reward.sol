//Create a staking contracts that allows users to stake ether for a particular time period and generate
// rewards on them.

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Staking_Reward
{
    
    address owner;

    struct Stakers 
    {
        uint stakerId;
        address stakerAddress;
        uint dateCreated;
        uint dateUnlocked;
        uint interestPercentage;
        uint amountStaked;
        uint interest;
        bool open;
    }

    Stakers staker;

    uint totalStakers = 0;

    mapping (uint => Stakers) public stakers;
    mapping (address => uint[]) stakeIdbyAddress;
    mapping(uint => uint) levels;

    constructor()
    {
        owner=msg.sender;
        levels[30] = 5;
        levels[90] = 16;
        levels[180] = 32;
    }
 
    function stake_ether(uint _amount, uint _numOfDays) public payable 
    {
        require(_amount == msg.value,"please check value and amount");
        require(msg.value <= owner.balance,"you havn't enough balance");
        require(levels[_numOfDays] > 0,"check your time period ");

        stakers[totalStakers] = Stakers (
            totalStakers,
            msg.sender,
            block.timestamp,
            block.timestamp + (_numOfDays * 1 days),    
            levels[_numOfDays],
            msg.value,
            ( levels[_numOfDays] * msg.value )/ 100,
            true
        );
        stakeIdbyAddress[msg.sender].push(totalStakers);
        totalStakers++;
    }

    function getStakersById(uint _stakerId) public view returns (Stakers memory)
    {
        return stakers[_stakerId];
    }

    function withdraw_ether(uint _id) public
    {
        require(stakers[_id].stakerAddress == msg.sender,"You are not staker" );
        require(stakers[_id].open == true, "Matic already withdrawn");

        stakers[_id].open = false;

        if(block.timestamp > stakers[_id].dateUnlocked )
        {
            uint amount = stakers[_id].amountStaked + stakers[_id].interest;
            payable(msg.sender).transfer(amount);   
        }
        else
        {
            payable(msg.sender).transfer(stakers[_id].amountStaked);
        }
    }

    function changeUnlockPeriod(uint256 _id, uint256 _newUnlockPeriod) public
    {
        require(msg.sender == owner);
        stakers[_id].dateUnlocked = _newUnlockPeriod;
    }
}