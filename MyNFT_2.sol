// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MYNFT is ERC721, ERC721Enumerable, Ownable 
{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint public minRate = 0.01 ether;
    uint public MAX_SUPPLY = 1000;


    constructor() ERC721("MYNFT", "MNFT") 
    {

    }

    function _baseURI() internal pure override returns (string memory) 
    {
        return "https://api.mynft.com/tokens/";
    }

    function safeMint(address to) public payable
    {
        require(totalSupply() < MAX_SUPPLY,"Can't Mint more");
        require(msg.value >= minRate,"Not enough Fund");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize) internal override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function withdraw() public onlyOwner
    {
        require(address(this).balance > 0,"Balance is 0");
        payable(owner()).transfer(address(this).balance);
    }
}