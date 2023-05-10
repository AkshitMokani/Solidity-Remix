// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Token {

    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Variables
    uint256 public totalSupply;
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    // Functions
    function transfer(address _to, uint256 _value) public {
        require(balanceOf[msg.sender] >= _value && _value > 0, "Insufficient balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
    }

    function approve(address _spender, uint256 _value) public {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public {
        require(balanceOf[_from] >= _value && allowance[_from][msg.sender] >= _value && _value > 0, "Insufficient balance or allowance");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
    }
}

contract CrowdSale is Token {

    uint256 public price;
    uint256 public tokensSold;

    constructor() {
        price = 10**15;
        totalSupply = 1000000;
    }

    function buyTokens() public payable {
        require(msg.value >= price, "Minimum purchase amount is 0.001 ETH");
        uint256 tokens = msg.value / price;
        balanceOf[msg.sender] += tokens;
        tokensSold += tokens;
        totalSupply -= tokens;
        emit Transfer(address(0), msg.sender, tokens);
    }
}
