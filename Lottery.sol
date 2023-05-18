// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Lottery {
    address public manager;

    struct Winner {
        address winnerAddress;
        uint256 winAmount;
    }

    mapping(address => uint256) public bidAmounts;
    mapping(address => bool) public hasEntered;
    mapping(uint256 => Winner) public winners;
    uint256 public winnerCount;

    address payable[] players;
    uint256 public fee = 0.01 ether;
    uint256 public maxEntries = 10;
    bytes32 salt = "some-random-string";

    constructor() {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value >= fee, "Minimum entry fee required");
        require(players.length < maxEntries, "Maximum entries reached");

        if (!hasEntered[msg.sender]) {
            players.push(payable(msg.sender));
            hasEntered[msg.sender] = true;
        }

        bidAmounts[msg.sender] += msg.value;
    }

    function random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, players.length, salt)));
    }

    function pickWinner() public restricted {
        require(players.length > 0, "No players available");

        uint256 index = random() % players.length;
        address payable winnerAddress = players[index];
        uint256 winAmount = address(this).balance - fee;

        winners[winnerCount] = Winner(winnerAddress, winAmount);
        winnerCount++;

        winnerAddress.transfer(winAmount);

        delete players;
    }

    modifier restricted() {
        require(msg.sender == manager, "Only the manager can call this function");
        _;
    }

    function getPlayers() public view returns (address payable[] memory) {
        address payable[] memory uniquePlayers = new address payable[](players.length);
        uint256 uniquePlayerCount = 0;

        for (uint256 i = 0; i < players.length; i++) {
            if (hasEntered[players[i]]) {
                uniquePlayers[uniquePlayerCount] = players[i];
                uniquePlayerCount++;
            }
        }

        // Resize the uniquePlayers array to remove any unused slots
        assembly {
            mstore(uniquePlayers, uniquePlayerCount)
        }

        return uniquePlayers;
    }

    function getWinners() public view returns (Winner[] memory) {
        Winner[] memory winnersArray = new Winner[](winnerCount);

        for (uint256 i = 0; i < winnerCount; i++) {
            winnersArray[i] = winners[i];
        }

        return winnersArray;
    }

    function refund() public {
        require(hasEntered[msg.sender]);

        uint256 refundAmount = bidAmounts[msg.sender] - fee;
        if (refundAmount > 0) {
            payable(msg.sender).transfer(refundAmount);
        }
    }
}
