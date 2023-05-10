// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract mySchool
{
    struct School
    {
        string studentName;
        uint rollNo;
    }

    // mapping(uint => string) public getsname;
    // mapping(string => uint) public getrno;

    School public s1;

    function addStudent() public
    {
        s1 = School('A',1);
        // getsname[rno]=sname;
        // getrno[sname]=rno;      
    }

    function getStudentName() public view returns(string memory)
    {
        return s1.studentName;
    }

    function getStudentRollNo() public view returns(uint)
    {
        return s1.rollNo;
    }
}