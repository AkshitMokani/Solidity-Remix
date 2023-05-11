// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "https://github.com/Uniswap/v2-periphery/blob/master/contracts/interfaces/IUniswapV2Router02.sol";
import "https://github.com/Uniswap/v2-core/blob/master/contracts/interfaces/IUniswapV2Factory.sol";


interface IERC20
{
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

interface SushiSwapRouter 
{
    function deposit(
        IERC20 token_,
        address from,
        address to,
        uint256 amount,
        uint256 share
    ) external payable returns (uint256 amountOut, uint256 shareOut);

    function _tokenBalanceOf(IERC20 token) external view returns (uint256 amount);
}

contract Sushiswap
{
    address sushiswapRouter = 0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506;
    address tokenA = 0x187F663A6c9E9Ac15f6224195C7C8D932703e37a; //SLDT 
    address tokenB = 0x6a276fa78587a0B1F1F7b54964830008ab298a8a; //SolZero 
    // DAI 0xF14f9596430931E177469715c591513308244e8F
    address SushiV2Factory = 0xc35DADB65012eC5796536bD9864eD8773aBc74C4;

    function addLiquidity(uint amtA, uint amtB) public
    {
        // uint amtA = IERC20(tokenA).balanceOf(address(this));
        // uint amtB = IERC20(tokenB).balanceOf(address(this));

        // IERC20(tokenA).transferFrom(msg.sender,address(this),amtA);
        // IERC20(tokenB).transferFrom(msg.sender,address(this),amtB);

        IERC20(tokenA).approve(sushiswapRouter,amtA);
        IERC20(tokenB).approve(sushiswapRouter,amtB);

        IUniswapV2Router02(sushiswapRouter).addLiquidity(
            tokenA,tokenB,
            amtA,amtB,
            0,0,
            address(this),
            block.timestamp
        );
    }
    
    function removeLiquidity() public 
    {
        address pair = IUniswapV2Factory(SushiV2Factory).getPair(tokenA,tokenB);

        uint liquidityAMount = IERC20(pair).balanceOf(address(this));

        IERC20(pair).approve(sushiswapRouter,liquidityAMount);

        IUniswapV2Router02(sushiswapRouter).removeLiquidity(
            tokenA,tokenB,
            liquidityAMount,
            0,0,
            msg.sender, //address(this)
            block.timestamp
        );
    }

    function swapExactTokensForTokens() public payable returns(uint)
    {
        uint amount = IERC20(tokenA).balanceOf(address(this));

        IERC20(tokenA).approve(sushiswapRouter,amount);

        address[] memory path = new address[](2);
        path[0] = tokenA;
        path[1] = tokenB;

        uint[] memory amtOut = IUniswapV2Router02(sushiswapRouter).getAmountsOut(amount,path);

        IUniswapV2Router02(sushiswapRouter).swapExactTokensForTokens(
            amount,
            0,
            path,
            address(this),
            block.timestamp
        );

        return amtOut[1];
    }

    //  function getBalance(address token, address account) external view returns (uint256) {
    //     // Get balance of a token for an account
    //     return IERC20(token).balanceOf(account);
    // }

     function getBalance() external view returns (uint256,uint256) {
        // Get balance of a token for an account
        return (IERC20(tokenA).balanceOf(address(this)),IERC20(tokenB).balanceOf(address(this)));
    }
}
