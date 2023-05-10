// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Rent
{
    address payable public Landlord;
    address payable public tenant;

    uint public rentAmount;
    // uint public securityDeposit;
    // uint public firstRentAmount;
    //uint public moveInDate;
    //uint public moveOutDate;
    //bool public moveInConfirmed;
    //bool public moveOutConfirmed;

    constructor(uint _rentAmount)
    {
        Landlord=payable(msg.sender);
        rentAmount=_rentAmount;
        // securityDeposit=2*rentAmount;
        // firstRentAmount=rentAmount+securityDeposit;
    }

    // function paySecutiryDeopsit() public payable
    // {
    //     // require(address(this).balance == rentAmount,"There is alreday tenant");
    //     require(msg.value==securityDeposit,"Incorrect amount of security Deposit");
    //     // require(msg.sender != Landlord,"Owner can't pay security Deposit");        
    // }

    // function firstRentPay() public returns(uint)
    // {
    //     firstRentAmount=rentAmount+securityDeposit;
    //     return(firstRentAmount);
    // }

    // function Be_Tenant() public payable 
    // {
    //     if (address(this).balance == 0 || address(this).balance < rentAmount) 
    //     {
    //         uint firstRent = rentAmount + securityDeposit;
    //         require(msg.value == firstRent, "Incorrect amount sent");
    //         tenant = payable(msg.sender);
    //         (bool success, ) = Landlord.call{value: msg.value}("");
    //         require(success, "Transfer failed.");
    //     }
    //     else
    //     {
    //         require(msg.value == rentAmount, "Wrong amount sent");
    //         require(msg.sender != Landlord, "You can't be the tenant in your own house");
    //         require(address(this).balance == rentAmount, "There is already a tenant");
    //         tenant = payable(msg.sender);
    //         (bool success, ) = address(this).call{value: msg.value}("");
    //         require(success, "Transfer failed.");
    //     }
    // }


    // function Be_Tenant() public payable 
    // {
    //     // require(msg.sender != Landlord,"You can't be tenant in your house");
    //     if(address(this).balance == 0)
    //     {
    //         require(msg.value==firstRentAmount,"Incorrect Amount sent");
    //         // tenant=payable(msg.sender);
    //         payable(msg.sender).transfer(msg.value);
    //     }
    //     require(msg.value==500,"wrong Amount");
    //         // require(address(this).balance == rentAmount,"There is alreday tenant");
    //         // tenant=payable(msg.sender);
    //     payable(msg.sender).transfer(msg.value);
    // }

    function Be_Tenant() public payable
    {
        require(msg.sender != Landlord,"You can't be tenant in your house");
        require(msg.value==rentAmount,"Incorrect Amount sent");
        require(address(this).balance == rentAmount,"There is alreday tenant");
        tenant=payable(msg.sender);
    }

    function checkRent() public view returns(bool)
    {
        // require(Landlord==msg.sender,"Only Landlord check the amount");
        if(address(this).balance == rentAmount)
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