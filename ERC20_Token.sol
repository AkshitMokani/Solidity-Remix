// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

interface IERC20 {

    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);


    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}


contract ERC20_Token is IERC20 {

    string  public  name;
    string  public  symbol;
    uint8   public  decimals;
    uint totalSupply_;

    mapping(address => uint) balances;
    mapping(address => mapping (address => uint)) allowed;


    constructor()  {
        name = "Solidity";
        symbol = "SLDT";
        decimals = 18;
        totalSupply_ =100;         //1000000000000000000000;     // total tokens would equal (totalSupply_/10**decimals)=1000
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public override view returns (uint) {
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public override view returns (uint) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint amount) public override returns (bool) {
        require(amount <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - (amount);
        balances[receiver] = balances[receiver] + (amount);
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function approve(address spender, uint numTokens) public override returns (bool) {
        allowed[msg.sender][spender] = numTokens;
        emit Approval(msg.sender, spender, numTokens);
        return true;
    }

    function allowance(address owner, address spender) public override view returns (uint) {
        return allowed[owner][spender];
    }

    function transferFrom(address owner, address to, uint numTokens) public override returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] -= numTokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender] - (numTokens);
        balances[to] += numTokens;
        emit Transfer(owner, to, numTokens);
        return true;
    }

}

