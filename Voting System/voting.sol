/* ----------------- Task -----------------
Create a voting contract with the following methods :-
    1. Vote - There will be some Candidates, users can vote for one of them by putting their id no. Users can only vote once.
    2. Voters – returns all the voters (address), who have voted
    3. checkVote – users can check if they have voted or not
    4. totalVotes – returns the total numbers of votes for each id
    5. finalizeVote – returns the winner id/candidate who has the maximum vote.
*/
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/Math.sol";


contract voting
{
    struct voters
    {
        string name;
        uint age;
    }

    bytes32[] voterList; // vote list of voted who voted
    bytes32[] AllvoterList; // list of all voter;
    string[] Candidates = ["c1","c2","c3"];
    bytes32  voterId;

    // bool isVoteDone;
    bool voted;

    mapping(bytes32 => bool) isVoter; //Check voter is registered or not;
    mapping(bytes32 => bool) isVoted; //Check voted or not;
    mapping (bytes32 => voters) _voters; //mapping with structure;
    mapping (string => uint) VoteCount; //count the total vote;

    constructor(){}

    function view_Candidates() public view returns(string[] memory)
    {
        return Candidates;
    }

    function add_Voter(string memory _name, uint _age) public
    {
        require(_age >=18,"Age must be greater than 18");
        voterId = sha256(abi.encodePacked(_name,block.timestamp));
        _voters[voterId] = voters(_name,_age);
        isVoter[voterId]=true;
        AllvoterList.push(voterId);
    }

    function check_Candidate(string memory _candidate) public view returns(bool)
    {   
        for (uint i = 0; i < Candidates.length; i++)
        {
            if (keccak256(bytes(Candidates[i])) == keccak256(bytes(_candidate)))
            {
                // return (string(abi.encodePacked( _candidate ," is available: ")), true );
                return true;
            }
        }
        return false;
    }

    function give_vote(bytes32 _voterId,string memory _candidate) public
    {
        require(isVoter[_voterId]==true,"You are not Voter");
        require(check_Candidate(_candidate),"Invalid Candidate");
        require(!isVoted[_voterId],"already voted");       
        VoteCount[_candidate]++;
        isVoted[_voterId]=true;
        if(isVoted[_voterId]=true)
        {
            voterList.push(_voterId);
        }
    }

    function check_vote(bytes32 _voterId) public view returns(string memory)
    {
        if(!isVoted[_voterId])
        {
            return "Vote Pending!!!";
        }
        else
        {
            return "Yes,You already voted";
        }
    }
    function view_vote_count(string memory _candidate) public view returns(uint)
    {
        require(check_Candidate(_candidate),"Invalid Candidate");
        return VoteCount[_candidate];
    }

    function view_Winner() public view returns(string memory,uint)
    {
        // return VoteCount[Candidates[1]];

        if(VoteCount[Candidates[0]] > VoteCount[Candidates[1]] && VoteCount[Candidates[0]] > VoteCount[Candidates[2]] )
        {
            return ("C1 is Winner", VoteCount[Candidates[0]]);
        }
        else if(VoteCount[Candidates[1]] > VoteCount[Candidates[0]] && VoteCount[Candidates[1]] > VoteCount[Candidates[2]] )
        {
            return ("C2 is Winner", VoteCount[Candidates[1]]);
        }
        else if(VoteCount[Candidates[2]] > VoteCount[Candidates[0]] && VoteCount[Candidates[2]] > VoteCount[Candidates[1]] )
        {
            return ("C3 is Winner", VoteCount[Candidates[2]]);
        }
        else
        {
            return("No Voting Happened",0);
        }
    }

    // function view_voters() public view returns (bytes32, string memory, uint) 
    // {
    //     voters memory voter = _voters[voterId]; //to show last added voter.
    //     return (voterId, voter.name, voter.age);
    // }

    function get_Voter_Details(bytes32 _voterId) public view returns (string memory, uint) 
    {
        return (_voters[_voterId].name, _voters[_voterId].age);
    }

    function view_Voted_Voters() public view returns(bytes32[] memory)
    {
        require(isVoted[voterId]==true,"No Voters");
        return (voterList);
    }

    function All_Voter_List() public view returns(bytes32[] memory)
    {
        return AllvoterList;
    }
}