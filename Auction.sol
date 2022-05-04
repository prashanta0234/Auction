// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0<0.9.0;

contract Auction{
    address payable public manager;
    uint public endingTime;
    uint public minimumBid;   
    address public heightBider;
    uint public heightBid;
    address payable public owner;

    struct Bidtype{
        uint amount;
        bool isBid;
    }
    mapping(address=>Bidtype) public bids;
    constructor(uint EndingTime,uint MinumumBid,address _owner){
        manager=payable(msg.sender);
        endingTime=block.timestamp+EndingTime;
        minimumBid=MinumumBid;
        owner=payable(_owner);

    }
    modifier isManger {
        require(msg.sender==manager,"Sorry you are not the manager.");
        _;
    }
    function bid() public payable {
        require(msg.sender != manager,"Sorry manager not allowed for biding");
        require(bids[msg.sender].isBid==true||minimumBid <= msg.value,"Please Send minimum value");
        require(bids[msg.sender].amount+msg.value> heightBid,"Please Bid more.");      
        bids[msg.sender].isBid=true;
        uint temp =bids[msg.sender].amount +=msg.value;       
        if(heightBid<temp){
            heightBid=temp;
            heightBider=msg.sender;
        }
       
    }
    function end() public{
        
    }
    
}