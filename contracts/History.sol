pragma solidity ^0.4.24;

contract History {
    // movement history of an address
    mapping(address => mapping(uint => string[])) history;
    // the number of steps in a specific day
    mapping(address => mapping(uint => uint)) stepsValue;
    // the expiration time of fetching history permission (seconds)
    mapping(address => mapping(address => uint)) expirationTime;
    
    /** 
     *  Add a step in a specific day
     *  date: ddmmyyyy (ex: 16092018 - Sep 16th 2018)
     *  step: lat,lng,time (ex: 21.027763,105.834160,1538758453973)
     */
    function addStep(uint date, string step) public{
        history[msg.sender][date].push(step);
        stepsValue[msg.sender][date]++;
    }
    
    /**
     *  Get a single step by address, time and index of step in day
     *  addr: target address
     *  date: ddmmyyyy (ex: 16092018 - Sep 16th 2018)
     *  index: index of that step
     */
    function getStep(address addr, uint date, uint index) public view returns(string){
        // the permission must be unexpired!
        require((msg.sender == addr) || (expirationTime[addr][msg.sender] > now));

        return history[addr][date][index];
    }

    /**
     *  Get the number of steps in a specific day
     *  addr: target address
     *  date: ddmmyyyy (ex: 16092018 - Sep 16th 2018)
     */
    function getStepsValue(address addr, uint date) public view returns(uint){
        return stepsValue[addr][date];
    }

    /**
     * Renew the expiration time
     * addr: address of the requestor
     * newTime: new expiration time in seconds
     */
    function renewExpirationTime(address addr, uint newTime) public {
        expirationTime[msg.sender][addr] = newTime;
    }
    
    /**
     * Get expiration time of an address on target address
     */
    function getExpirationTime(address targetAddr, address addr) public view returns(uint){
        return expirationTime[targetAddr][addr];
    }
}
