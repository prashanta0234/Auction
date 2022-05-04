// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0<0.9.0;

contract Auction{
    address payable public manager;
    uint public endingTime;
    uint public minimumBid;   
    address public heightBider;
    uint public heightBid;
    address payable public owner;
    bool public isEnd;
    uint public numberOfBiders;

    struct Bidtype{
        uint amount;
        bool isBid;
        
    }
    struct storeBiders{
        uint amount;
        address payable bider;
        bool winner;

    }
    mapping(address=>Bidtype) public bids;
    mapping(uint=>storeBiders) public biddres;
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
    modifier running{
        require(block.timestamp<endingTime,"Auction is end!");
        require(isEnd==false);
        _;
    }
    function bid() public payable running {
        require(msg.sender != manager,"Sorry manager not allowed for biding");
        require(bids[msg.sender].isBid==true||minimumBid <= msg.value,"Please Send minimum value");
        require(bids[msg.sender].amount+msg.value> heightBid,"Please Bid more.");      
        storeBiders storage bidresInfo=biddres[numberOfBiders];
        bidresInfo.amount+=msg.value;
        bidresInfo.bider=payable(msg.sender);
        
        
       uint temp =bids[msg.sender].amount +=msg.value;       
        if(heightBid<temp){
            heightBid=temp;
            heightBider=msg.sender;
        }
        if(bids[msg.sender].isBid==false){
            numberOfBiders++;
        }
        bids[msg.sender].isBid=true;
        
       
    }
    function end() public isManger{
        isEnd=true;


    }
    
}