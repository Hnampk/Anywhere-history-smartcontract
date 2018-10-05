pragma solidity ^0.4.24;

contract History {
    // movement history of an address
    mapping(address => mapping(uint => string[])) history;
    // the number of steps in a specific day
    mapping(address => mapping(uint => uint)) stepsValue;

    /** 
     *  Add a step in a specific day
     *  time: mmddyyyy (ex: 09162018 - Sep 16th 2018)
     *  step: lat,lng,time (ex: 21.027763,105.834160,1538758453973)
     */
    function addStep(uint time, string step) public{
        history[msg.sender][time].push(step);
        stepsValue[msg.sender][time]++;
    }
    
    /**
     *  Get a single step by address, time and index of step in day
     *  addr: target address
     *  time: mmddyyyy (ex: 09162018 - Sep 16th 2018)
     *  index: index of that step
     */
    function getStep(address addr, uint time, uint index) public view returns(string){
        return history[addr][time][index];
    }

    /**
     *  Get the number of steps in a specific day
     *  addr: target address
     *  time: mmddyyyy (ex: 09162018 - Sep 16th 2018)
     */
    function getStepsValue(address addr, uint time) public view returns(uint){
        return stepsValue[addr][time];
    }
}
