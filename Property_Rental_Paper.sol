// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract RentAgreement
{
    /* This declares a new complex type which will hold the paid rents*/
    struct PaidRent
    {
        uint id; 
        uint value;
    }

    PaidRent[]  paidrents;
    uint  createdTimestamp;
    uint  rent;
    string  house;
    address payable  landlord;
    address  tenant;
    enum State {Created,Started,Terminated}
    State  state;

    function RentalAgreement(uint _rent, string memory _house) public
    {
        rent = _rent;
        house = _house;
        landlord = payable(msg.sender);
        createdTimestamp=block.timestamp;
    }

     modifier condition(bool _condition) 
    {
        require(_condition, "Condition not met");
        _;
    }
    modifier onlyLandlord() {
        require(msg.sender != landlord);
        _;
    }
    modifier onlyTenant() {
        require(msg.sender != tenant);
        _;
    }
    modifier inState(State _state) {
        require(state != _state);
        _;
    }

     function getPaidRents() internal view returns (PaidRent[] memory) 
    {
        return paidrents;
    }

    function getHouse() public view returns (string memory)
    {
        return house;
    }

    function getLandlord() public view returns (address)
    {
        return landlord;
    }

    function getTenant() public view returns (address)
    {
        return tenant;
    }

    function getRent() public view returns (uint)
    {
        return rent;
    }

    function getContractCreated() public view returns (uint)
    {
        return createdTimestamp; 
    }

    function getContractAddress() public view returns (address)
    {
        return address(this);
    }

    function getState() public view returns (State)
    {
        return state;
    }

    event agreementConfirmed();
    event paidRent();
    event contractTerminated();

    function confirmAgreement() public inState(State.Created) onlyLandlord
    {
        emit agreementConfirmed();
        tenant = msg.sender;
        state = State.Started;
    }

    function payRent() public onlyTenant inState(State.Started) payable
    {
        require(msg.value==rent);
        emit paidRent();
        landlord.transfer(msg.value);
        paidrents.push(PaidRent({id : paidrents.length + 1,value : msg.value}));
    }

    function terminateContract() public onlyLandlord
    {
        emit contractTerminated();
        landlord.transfer(address(this).balance);
        state = State.Terminated;
    }
}