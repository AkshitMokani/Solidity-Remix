// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
}

interface IAaveV2 {
    function deposit(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
    function withdraw(address asset, uint256 amount, address to) external;
}

contract AaveImplementation {
    IAaveV2 private aave;
    address private constant WETH_ADDRESS = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2; // Wrapped Ether contract address
    address private constant AAVE_ADDRESS = 0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9; // Aave V2 contract address
    uint256 private constant MAX_UINT256 = 2**256 - 1;

    constructor() {
        aave = IAaveV2(AAVE_ADDRESS);
    }

    function depositEther(address onBehalfOf) external payable {
        // Deposit Ether into Aave
        aave.deposit(WETH_ADDRESS, msg.value, onBehalfOf, 0);
    }

    function depositERC20(address erc20Token, uint256 amount, address onBehalfOf) external {
        // Approve Aave to transfer the ERC20 tokens
        IERC20(erc20Token).approve(AAVE_ADDRESS, MAX_UINT256);
        
        // Deposit ERC20 tokens into Aave
        aave.deposit(erc20Token, amount, onBehalfOf, 0);
    }

    function withdraw(address token, uint256 amount, address to) external {
        // Withdraw tokens from Aave
        aave.withdraw(token, amount, to);
    }

    function getBalance(address token, address account) external view returns (uint256) {
        // Get balance of a token for an account
        return IERC20(token).balanceOf(account);
    }
}
