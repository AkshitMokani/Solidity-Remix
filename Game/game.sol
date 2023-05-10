// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract game
{

    address public player1;
    address public player2;

    bool public gameOver;

    uint[3] move = [1,2,3];

    uint[2] storeMove;
    // Define mapping for possible moves and their results
    mapping (uint => mapping (uint => string)) results;
    constructor()
    {

    }

    function setPlayer1() external {
        require(player1 == address(0), "Player 1 is already set");
        player1 = msg.sender;
    }

    function setPlayer2() external {
        require(player1 != address(0), "Player 1 must be set before setting player 2");
        require(player2 == address(0), "Player 2 is already set");
        require(msg.sender != player1, "Player 2 address cannot be the same as Player 1");
        player2 = msg.sender;
    }

    function view_player() public view returns(address , address)
    {
        return (player1,player2);
    }

    function view_Move() public pure returns(string memory,string memory,string memory)
    {
        return("Stone = 1"," Paper = 2", "Scissor = 3" );
    }

    function player1_move(uint number) public payable returns(string memory)
    {
        require(number == move[0] || number == move[1] || number == move[2]);
        require(msg.sender == player1 , "Only players can make a move");
        require(msg.value == 1000000000000000000,"please check value, it must be 1 Ether");
        require(!gameOver, "The game is over, please start a new game to play again");

        // require(storeMove[0] == 0 ,"Values are already set");

        storeMove[0] = number;

        if(number == move[0])
        {
            return "Stone";
        }
        else if(number == move[1])
        {
            return "Paper";
        }
        else if(number == move[2])
        {
            return "Scissor";
        }
        else
        {
            return "";
        }

        // return number;
    }

    function player2_move(uint number) public payable returns(string memory)
    {
        require(number == move[0] || number == move[1] || number == move[2]);
        require(msg.sender == player2, "Only players can make a move");
        require(msg.value == 1000000000000000000,"please check value, it must be 1 Ether");
        require(storeMove[0] != 0,"it's Player 1 Move");
        require(!gameOver, "The game is over, please start a new game to play again");
        // require(storeMove[1] == 0 ,"Values are already set");

        storeMove[1] = number;

        if(number == move[0])
        {
            return "Stone";
        }
        else if(number == move[1])
        {
            return "Paper";
        }
        else if(number == move[2])
        {
            return "Scissor";
        }
        else
        {
            return "";
        }

        // return number;
    }

    function Check_Winner() public payable returns(string memory) 
    {   
        require(storeMove[0] != 0 && storeMove[1] != 0, "Both players must make a move before checking for a winner");

        results[1][1] = "Its Draw";
        results[1][2] = "Player 2 Win";
        results[1][3] = "Player 1 Win";
        results[2][1] = "Player 1 Win";
        results[2][2] = "Its Draw";
        results[2][3] = "Player 2 Win";
        results[3][1] = "Player 2 Win";
        results[3][2] = "Player 1 Win";
        results[3][3] = "Its Draw";

        // Look up result based on player moves
        string memory result = results[storeMove[0]][storeMove[1]];

        // Transfer 1.8x the player's bet to the winner
        uint betAmount = 1000000000000000000;
        uint payoutAmount = 0;
        if (keccak256(abi.encodePacked(result)) == keccak256(abi.encodePacked("Player 1 Win"))) 
        {
            payoutAmount = (betAmount * 18) / 10;
            payable(player1).transfer(payoutAmount);
        }
        else if (keccak256(abi.encodePacked(result)) == keccak256(abi.encodePacked("Player 2 Win"))) 
        {
            payoutAmount = (betAmount * 18) / 10;
            payable(player2).transfer(payoutAmount);
        }

         // Set gameOver to true and return the result
        gameOver = true;
        return result;
    }


    // function Check_Winner() public view returns(string memory)
    // {
    //     require(storeMove[0] != 0 && storeMove[1] != 0, "Both players must make a move before checking for a winner");

    //     if(storeMove[0]==1 && storeMove[1]==1)
    //     {
    //         return "Its Draw";
    //     }
    //     else if(storeMove[0]==1 && storeMove[1]==2)
    //     {
    //         return "Player 2 Win";
    //     }
    //     else if(storeMove[0]==1 && storeMove[1]==3)
    //     {
    //         return "Player 1 Win";
    //     }


    //     else if(storeMove[0]==2 && storeMove[1]==2)
    //     {
    //         return "Its Draw";
    //     }
    //     else if(storeMove[0]==2 && storeMove[1]==1)
    //     {
    //         return "Player 1 Win";
    //     }
    //     else if(storeMove[0]==2 && storeMove[1]==3)
    //     {
    //         return "Player 2 Win";
    //     }


    //     else if(storeMove[0]==3 && storeMove[1]==3)
    //     {
    //         return "Its Draw";
    //     }
    //     else if(storeMove[0]==3 && storeMove[1]==1)
    //     {
    //         return "Player 2 Win";
    //     }
    //     else if(storeMove[0]==3 && storeMove[1]==2)
    //     {
    //         return "Player 1 Win";
    //     }

    //     else
    //     {
    //         return "play First";
    //     }
    // }
}