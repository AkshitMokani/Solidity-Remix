// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Rent_with_Array
{
    address payable public Landlord;
    address payable tenant;
    uint public rentAmount;

    address[] public Tenant;

    // mapping (uint => address) tenants;

    constructor(uint _rentAmount)
    {
        Landlord=payable(msg.sender);
        rentAmount=_rentAmount;
    }

    function cheklen() public view returns(uint)
    {
        return Tenant.length;
    }

    function Be_Tenant() public payable 
    {
        require(msg.sender != Landlord, "You can't be tenant in your own house");
    
        bool tenantExists = false;
        for (uint i = 0; i < Tenant.length; i++) 
        {
            if (msg.sender == Tenant[i]) 
            {
                tenantExists = true;
                break;
            }
        }
    
        if (tenantExists) 
        {
            require(msg.value == 500, "Please pay 500 wei");
        } 
        else 
        {
            require(msg.value == 1500, "Please pay 1500 wei");
            Tenant.push(msg.sender);
        }

    tenant = payable(msg.sender);
}

    function checkRent() public view returns(bool)
    {
        // require(Landlord==msg.sender,"Only Landlord check the amount");
        if(Tenant.length==1 && address(this).balance == 1500)
        {
            return true;
        }
        else if(address(this).balance >= 1500 )
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    function getAmount() public view returns(uint)
    {
        return address(this).balance;
    }

    function transferRent() public payable
    {
        require(msg.sender == Landlord,"Only Landlord can transfer this balance");
        Landlord.transfer(address(this).balance);
    }
}