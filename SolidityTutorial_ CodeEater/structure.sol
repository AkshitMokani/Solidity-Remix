// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract structure1
{
    struct Student
    {
        uint roll;
        string name;
    }

    Student public s1;

    constructor(uint _roll, string memory _name)
    {
        s1.roll=_roll;
        s1.name=_name;
    }

    function change(uint _roll, string memory _name) public
    {
        Student memory new_student=Student
        (
            {
                roll:_roll, 
                name:_name
            }
        );
        s1=new_student;
    }
    
}