// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract to_do_List
{
    string[] list;
    string[] completedTaskList;
    
    mapping(uint => mapping(string => bool)) public completeTask;
    //  mapping(uint => string) public tasks;
    //mapping(uint => bool) public completeTask;

    function addTask(string memory task) public
    {
        list.push(task);
        //tasks[tasknumber]=task;
    }

    function viewCompleteTask() public view returns(string[] memory)
    {
        return completedTaskList;
    }

    function addtoCompleteTask(uint tasknum,string memory task) public 
    {
        completeTask[tasknum][task] = true;
        if(completeTask[tasknum][task] = true)
        {
            completedTaskList.push(task);
        }
    }

    function addtoPendingTask(uint tasknum, string memory task) public
    {
        completeTask[tasknum][task] = false;
    }

    function AllTask() public view returns(string[] memory)
    {
        return list;
    }

     function length() public view returns(uint)
    {
        return list.length;
    }
}
