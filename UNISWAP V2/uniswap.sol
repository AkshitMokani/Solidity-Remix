// SPDX-License-Identifier: MIT

pragma solidity ^0.6.2;

import "https://github.com/Uniswap/v2-periphery/blob/master/contracts/interfaces/IUniswapV2Router02.sol";
import "https://github.com/Uniswap/v2-core/blob/master/contracts/interfaces/IUniswapV2Factory.sol";

interface IERC20 
{
    function approve(address spender, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract uniswap
{
    address routerV2 = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D; 
    address Factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;   
    address WETH = 0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6;

    address tokenA = 0x6a276fa78587a0B1F1F7b54964830008ab298a8a ;
    address tokenB = 0x187F663A6c9E9Ac15f6224195C7C8D932703e37a ;



    function addLiquidity() public
    {
        uint amtA = IERC20(tokenA).balanceOf(address(this));
        uint amtB = IERC20(tokenB).balanceOf(address(this));

        IERC20(tokenA).transferFrom(msg.sender,address(this),amtA);
        IERC20(tokenB).transferFrom(msg.sender,address(this),amtB);

        IERC20(tokenA).approve(routerV2,amtA);
        IERC20(tokenB).approve(routerV2,amtB);

        IUniswapV2Router02(routerV2).addLiquidity(
            tokenA,tokenB,
            amtA,amtB,
            0,0,
            address(this),
            block.timestamp
        );
    }

    function removeLiquidity() public
    {
        address pair = IUniswapV2Factory(Factory).getPair(tokenA, tokenB);

        uint liquidityAmt = IERC20(pair).balanceOf(address(this));

        IERC20(pair).approve(routerV2,liquidityAmt);

        IUniswapV2Router02(routerV2).removeLiquidity(
            tokenA,tokenB,
            liquidityAmt,
            0,0,
            address(this),
            block.timestamp
        );
    }

    receive() external payable {}


    function addLiquidityETH() public payable
    {
        uint amtA = IERC20(tokenA).balanceOf(address(this));

        IERC20(tokenA).transferFrom(msg.sender,address(this),amtA);
        IERC20(tokenA).approve(routerV2,amtA);

        IUniswapV2Router02(routerV2).addLiquidityETH{value : address(this).balance}(
            tokenA,
            amtA,
            0,0,
            msg.sender,
            block.timestamp
        );
    }

    function removeLiquidityETH() public
    {
        address pair = IUniswapV2Factory(Factory).getPair(tokenA,WETH);
        
        uint liquidityamt = IERC20(pair).balanceOf(address(this));

        IERC20(pair).approve(routerV2,liquidityamt);

        IUniswapV2Router02(routerV2).removeLiquidityETH(
            tokenA,
            liquidityamt,
            0,0,
           address(this),
            block.timestamp
        );
    }

    function swapExactTokensForTokens() public payable returns(uint)
    {
        uint amt = IERC20(tokenA).balanceOf(address(this));

        IERC20(tokenA).transferFrom(msg.sender,address(this),amt);
        IERC20(tokenA).approve(routerV2,amt);

        address[] memory path = new address[](2);
        path[0] = tokenA;
        path[1] = tokenB;

        //function getAmountsOut(uint amountIn, address[] memory path) public view returns (uint[] memory amounts);
        uint[] memory amtOut = IUniswapV2Router02(routerV2).getAmountsOut(amt,path);

        IUniswapV2Router02(routerV2).swapExactTokensForTokens(
            amt,
            0,
            path,
            address(this),
            block.timestamp
        );
         
        return amtOut[1];
    }

    function swapTokensForExactTokens() public payable 
    {
        address[] memory path = new address[](2);
        path[0] = tokenA; //input Token
        path[1] = tokenB; //Output Token


        uint bal = IERC20(tokenA).balanceOf(address(this));

        //function transferFrom(address from, address to, uint256 amount) external returns (bool);
        // Transfer input token to this contract
        IERC20(tokenA).transferFrom(msg.sender,address(this),bal);
        IERC20(tokenA).approve(routerV2,bal);

        uint[] memory amt = IUniswapV2Router02(routerV2).getAmountsOut(bal,path);

        IUniswapV2Router02(routerV2).swapTokensForExactTokens(
            amt[1],
            bal,
            path,
            address(this),
            block.timestamp
        );
    }
}
