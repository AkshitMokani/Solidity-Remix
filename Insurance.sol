// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Insurance
{
    struct user
    {
        bool isUID;
        string name;
        uint Insured_Amount;
    }

    mapping (bytes32 => user) public userMapping;
    mapping (address => bool) public doctorMapping;

    address Owner;

    constructor()
    {
        Owner=msg.sender;
    }

    modifier onlyOwner()
    {
        require(Owner==msg.sender,"Only Owner can");
        _;
    }

    function setDoctor(address adrs) public onlyOwner
    {
        require(!doctorMapping[adrs]);
        doctorMapping[adrs] = true;
    }

    function setUser(string memory _name, uint _Insured_Amount) public onlyOwner returns(bytes32)
    {
        bytes32 hash = sha256(abi.encodePacked(msg.sender,block.timestamp));
        require(!userMapping[hash].isUID);
        userMapping[hash].isUID = true;
        userMapping[hash].name = _name;
        userMapping[hash].Insured_Amount = _Insured_Amount;
        return hash;
    }

    function useInsurance(bytes32 _hash, uint amountUse) public onlyOwner returns(string memory)
    {
        require(doctorMapping[msg.sender], "Only doctor can use insurance");
        require(userMapping[_hash].Insured_Amount >= amountUse, "Insufficient insured amount");
        userMapping[_hash].Insured_Amount -= amountUse;
        return "Success";
    }
    
}