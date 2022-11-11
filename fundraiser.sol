// SPDX-License-Identifier: MIT
pragma solidity 0.8.1;

contract fundraiser
{
    //address of owner
    address payable owner;
    //goal amount
    uint public goal = 100 ether;
    //shoutout message
    string public message;
    //highest dono
    uint public highestDonation;
    //highest dono addy
    address public highestDonator;

    uint public balance = address(this).balance;

    //has to be declared before functions
    //sets owner to the person who deploys it
    constructor() {
        //converts from regular addy to payable addy
        owner = payable(msg.sender);
    }

    //memory can change
    //calldata acts as immutable
    //payable allows function get paid
    function deposit(string memory message1) payable public 
    {
        //only takes deposits if goal isnt acheived
        require(balance <= goal, "Goal is achieved");
        balance += msg.value;
        //
        if(msg.value > highestDonation)
        {
            highestDonation = msg.value;
            highestDonator = msg.sender;
        }
        message = message1;
    }
    //you can put uint amount in () as input for amount to withdraw
    function withdraw() public 
    {
        require(msg.sender == owner, "gtfo, btich");
        owner.transfer(balance);
    }
    /*
    function getMessage() public view returns (string memory) 
    {
        return message;
    }
    //pure is used to save gas on EVM
    function pureFu(int x , int y) pure public returns (int){
        return x+y;
    }
    */
}
