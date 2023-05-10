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
    event viewowner(address owner);
}

contract test is IERC20
{
    string public name;
    string public symbol;
    uint public decimal;

    address acOwner;

    uint total_Supply;

    mapping(address => uint) acBalance;
    mapping(address => uint) balance;
    mapping(address => mapping(address => uint)) allowed;

    constructor()
    {
        name = "Solidity";
        symbol = "SLDT";
        decimal = 18;

        acOwner = msg.sender;
        acBalance[acOwner]=acOwner.balance;

        total_Supply = 1000 * 10 ** decimal;     //100;   //1000000000000000000000;     // total tokens would equal (totalSupply_/10**decimals)=1000

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
        //amount-=(amount*5)/1000; //0.5% burning
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


     function buy(uint256 _amount) public payable {
        uint price = 1000000000000000; //0.001
        require(msg.value >= _amount*price, "Not enough ether !");
        uint256 tokenAmount = _amount * 10 ** decimal;

        balance[msg.sender] += tokenAmount;
        balance[acOwner] -= tokenAmount;

        payable(msg.sender).transfer(_amount);
        emit Transfer(acOwner, msg.sender, tokenAmount);
    }
    
    // function buy_Token(uint amount) public payable returns(bool)
    // {
    //     uint amountToPay = amount * 1000000000000000;
    //     require(msg.value==amountToPay,"Put correct Amount");
    //     acBalance[acOwner] -= amountToPay;
    //     amount=amount * 10 ** decimal;
    //     return true;
    // }

}



        //return acBalance[msg.sender];
        //return msg.sender;
        // acBalance[acOwner] += amount * 10 ** decimal;
        // acBalance[msg.sender]+=amount;
        // function buy_Token(uint amount) public payable returns(bool)
    // {
    //     uint amountToPay = amount * 1000000000000000;
    //     require(msg.value==amountToPay,"Put correct Amount");
    //     acBalance[acOwner] -= amountToPay;
    //     amount=amount * 10 ** decimal;
    //     acOwner.transfer(msg.value);
    //     return true;
    // }

//     function buy_Token(uint amount) public payable returns(bool)
// {
//     uint amountToPay = amount * 1000000000000000;
//     require(msg.value==amountToPay,"Put correct Amount");
//     // address payable acOwnerPayable = address(acOwner);
//     acOwner.transfer(msg.value);
//     amount=amount * 10 ** decimal;
//     return true;
// }