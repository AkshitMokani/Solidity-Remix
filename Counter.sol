//define version of solidity
pragma solidity ^0.6.0;

//create the basic smart contract with the contract keyword, followed by its name Counter.
contract Counter
{
    //create a new variable called count
    uint public count = 0; //The count is a uint, which stands for "Unsigned Integer". Basically, it's a non-negative number

    
    //function getCount() public view returns(uint)
    //{
    //    return count;
    //}

    function incrementCount() public
    {
        count ++;
    }
} 

/*we create a smart contract that counts numbers. For example, 
we could use this smart contract to keep score in a game. 
It will allow us to store the current score, or count, on the blockchain, and increase it whenever we we want.*/