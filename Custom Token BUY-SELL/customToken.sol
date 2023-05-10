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


contract CustomToken is IERC20 {

    string  public  name;
    string  public  symbol;
    uint8   public  decimals;
    uint totalSupply_;

    mapping(address => uint) balances;
    mapping(address => mapping (address => uint)) allowed;

    mapping(address => uint) SellList;
    mapping(address => uint) SellListPrice;

    address public TokenSeller;
    address public TokenBuyer;


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

    // uint quantity;
    // uint PerTokenPrice;

    function sellToken(uint quantity,uint PerTokenPrice) public
    {
        require(quantity <= balances[msg.sender],"You have't enough balance");
        require(PerTokenPrice >= 0,"Selling price can't be less than 0");
        TokenSeller=msg.sender;
        SellList[TokenSeller]=quantity;
        SellListPrice[TokenSeller]=PerTokenPrice;

    // subtract the sold tokens from the user's balance
        balances[TokenSeller] -= quantity;

    // add the sold tokens to the contract's balance
        balances[address(this)] += quantity;
    }


   function getSellOrder() public view returns (uint quantity, uint PerTokenPrice) 
   {
        if (SellList[msg.sender] > 0)
        {
            quantity = SellList[TokenSeller];
            PerTokenPrice=SellListPrice[TokenSeller];
        }
    }

    function Buy_Token(uint buyQty) public payable //view returns(uint)
    {
        require(msg.value > 0,"it must be greater than Zero");
        require(buyQty > 0,"Quantity must be greater than Zero");
        require(buyQty <= balances[TokenSeller],"please check quanity");
        uint totalPay = buyQty * SellListPrice[TokenSeller];
        require(msg.value==totalPay,"Check amount");
        require(totalPay <= (msg.sender).balance,"Check Your Total Balance");
        balances[address(this)] -= buyQty;
        TokenBuyer = msg.sender;
        balances[TokenBuyer] += buyQty;

        payable(TokenSeller).transfer(totalPay);
        //transfer(TokenSeller,totalPay);
    
        // return totalPay;
        //return SellList[TokenSeller];
    }

}

