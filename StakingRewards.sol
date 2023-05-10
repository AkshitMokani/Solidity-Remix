// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

interface IERC20
{
    function totalSupply() external view returns(uint);
    function balanceOf(address account) external view returns(uint);
    function allowance(address owner, address spender) external view returns(uint);
    
    function approve(address spender, uint amount) external returns(bool);
    function transfer(address recipient, uint amount) external returns(bool);
    function transferFrom(address sender, address recipient, uint amount) external returns(bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event approval(address indexed owner, address indexed spender, uint value);

}
contract StakingRewards
{
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardsToken;

    address public owner;

    uint public duration;
    uint public finishAt;
    uint public updatedAt;
    uint public rewardRate;
    uint public rewardPerTokenStored;

    mapping(address => uint) public userRewardPerTokenPaid;
    mapping(address => uint)  public reward;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    constructor(address _stakingToken, address _rewardsToken)
    {
        owner=msg.sender;
        stakingToken = IERC20(_stakingToken);
        rewardsToken = IERC20(_rewardsToken);
    }

    modifier onlyOwner()
    {
        require(msg.sender==owner,"You are not owner");
        _;
    }

    modifier updateReward(address _account) 
    {
        rewardPerTokenStored = rewardPerToken();
        updatedAt = lastTimeRewardApplicable();

        if (_account != address(0))
        {
            reward[_account] = earned(_account);
            userRewardPerTokenPaid[_account] = rewardPerTokenStored;
        }
        _;
    }

    function setRewardDuration(uint _duration) external onlyOwner
    {
        require(finishAt < block.timestamp, "reward duration not finished");
        duration = _duration;
    }

    function notifyRewardAmount(uint _amount) external onlyOwner updateReward(address(0))
    {
        if(block.timestamp > finishAt)
        {
            rewardRate = _amount / duration;
        }
        else
        {
            uint remainingRewards = rewardRate * (finishAt - block.timestamp);
            rewardRate = (remainingRewards + _amount) / duration;
        }
        require(rewardRate > 0, "reward rate = 0");
        require(rewardRate * duration <= rewardsToken.balanceOf(address(this)),"reward amount > balance");

        finishAt = block.timestamp + duration;
        updatedAt = block.timestamp;
    }

    function stake(uint _amount) external updateReward(msg.sender)
    {
        require(_amount > 0, " amount = 0");
        stakingToken.transferFrom(msg.sender, address(this), _amount);
        balanceOf[msg.sender] += _amount;
        totalSupply += _amount;
    }

    function withdraw(uint _amount) external updateReward(msg.sender) 
    {
        require(_amount > 0,"amount = 0");
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        stakingToken.transfer(msg.sender,_amount);

    }

    function lastTimeRewardApplicable() public view returns (uint) {
        return _min(finishAt, block.timestamp);
    }
    function _min(uint x, uint y) private pure returns (uint) {
        return x <= y ? x : y;
    }

    function rewardPerToken() public view returns(uint)
    {
        if(totalSupply == 0)
        {
            return rewardPerTokenStored;
        }
        return rewardPerTokenStored + (rewardRate * (lastTimeRewardApplicable() - updatedAt) * 1e18) / totalSupply;
    }

    function earned(address _account) public view returns(uint)
    {
        return (balanceOf[_account] * (rewardPerToken() - userRewardPerTokenPaid[_account] )) / 1e18 + reward[_account];
    }

    function getReward() external updateReward(msg.sender)
    {
        uint rewrd = reward[msg.sender];
        if(rewrd > 0)
        {
            reward[msg.sender] = 0;
            rewardsToken.transfer(msg.sender, rewrd);
        }
    }
}