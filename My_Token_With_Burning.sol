// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

interface IERC20
{
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function allowance(address owner, address receiver) external view returns (uint);

    function transfer(address receiver, uint amount) external returns (bool);
    function approve(address receiver, uint amount) external returns(bool);
    function transferFrom(address owner, address receiver, uint amount) external returns(bool);

    event Transfer(address owner, address receiver, uint amount);
    event Approval(address owner, address receiver, uint amount);
}

contract My_Token_With_Burning is IERC20
{
    string public name;
    string public symbol;
    uint public decimal;

    uint total_Supply;

    mapping(address => uint) balance;
    mapping(address => mapping(address => uint)) allowed;

    constructor()
    {
        name = "Solidity";
        symbol = "SLDT";
        decimal = 18;

        total_Supply = 1000 * 10 ** decimal;     //1000;   //1000000000000000000000;     // total tokens would equal (totalSupply_/10**decimals)=1000

        balance[msg.sender]=total_Supply;
    }

    function totalSupply() public override view returns (uint)
    {
        return total_Supply;
    }

    function balanceOf(address account) public override view returns (uint)
    {
        return balance[account];
    }

    function transfer(address receiver, uint amount) public override returns (bool)
    {
        require(amount <= balance[msg.sender]);
        balance[msg.sender] -= amount;
        amount-=(amount*5)/1000; //0.5% burning
        balance[receiver] += amount;
        emit Transfer(msg.sender,receiver,amount);
        return true;
    }

    function approve(address receiver, uint amount) public override returns(bool)
    {
        allowed[msg.sender][receiver]=amount;
        emit Approval(msg.sender,receiver,amount);
        return true;
    }

    function allowance(address owner, address receiver) public override view returns (uint)
    {
        return allowed[owner][receiver];
    }

    function transferFrom(address owner, address receiver, uint amount) public override returns(bool)
    {
        require(amount <= balance[owner]);
        require(amount <= allowed[msg.sender][owner]);

        balance[owner]-=amount;
        allowed[msg.sender][owner]-=amount;
        balance[receiver]+=amount;
        emit Transfer(msg.sender,receiver,amount);
        return true;
    }

}

