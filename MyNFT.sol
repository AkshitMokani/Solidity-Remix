// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyNFT is ERC721, ERC721Enumerable, Pausable, Ownable {
    using Counters for Counters.Counter;
    uint maxSupply = 2000;

    bool public publicMintOpen = false;
    bool public allowListMintOpen = false;

    mapping(address => bool) public allowList;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("MyNFT", "mnft")
    {

    }

    function _baseURI() internal pure override returns (string memory) 
    {
        return "    ";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // Modify the mint windrow
    function editMintWindows( bool _allowListMintOpen, bool _publicMintOpen) external onlyOwner
    {
        publicMintOpen =_publicMintOpen;
        allowListMintOpen = _allowListMintOpen;
    }

    function withdraw() external onlyOwner payable
    {
        // uint balance = address(this).balance;
        payable(msg.sender).transfer(address(this).balance);
    }

    function allowListMint() public payable
    {
        require(allowListMintOpen,"Allow list mint is closed");
        require(allowList[msg.sender],"You are not in the allowlist ");
        require(msg.value == 0.0001 ether,"Not Enough Fund");
        internalMint();
    }

    function publicMint() public payable
    {
        require(publicMintOpen,"Public mint closed");
        require(msg.value == 0.001 ether,"Not Enough Fund");
       internalMint();
    }

    function internalMint() internal
    {
        require(totalSupply() < maxSupply," We Sold Out");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    function setAllowList(address[] calldata addresses) external onlyOwner
    {
        for(uint i=0; i < addresses.length; i++)
        {
            allowList[addresses[i]] = true; 
        }
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize) internal whenNotPaused override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}