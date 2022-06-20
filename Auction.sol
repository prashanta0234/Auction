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
    address payable winner;
    bool public ownerChanged;

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
    modifier running{
        require(block.timestamp<endingTime,"Auction is end!");
        require(isEnd==false);
        _;
    }

    
    modifier isbider{
        require(bids[msg.sender].isBid==true);
        _;
    }
    function bid() public payable running {
        require(msg.sender != manager,"Sorry manager not allowed for biding");
        require(bids[msg.sender].isBid==true||minimumBid <= msg.value,"Please Send minimum value");
        require(bids[msg.sender].amount+msg.value> heightBid,"Please Bid more.");      
             
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
        winner=payable(heightBider);

    }
    function changeOwner()  public isManger{
        require(ownerChanged==false && isEnd==true,"Sorry Its not end yet.");
        ownerChanged=true;
         uint percent= (heightBid*10)/100;
        owner.transfer(heightBid-percent);
        owner=winner;
       
        manager.transfer(percent);

    }

    function Refund() public isbider payable{
        require(ownerChanged==true && isEnd==true,"Sorry Its not allowed");
        require(msg.sender != winner);
        address payable requestSender= payable(msg.sender);
        requestSender.transfer(bids[msg.sender].amount);

    }
    function balance() public view returns(uint _re){
        _re=address(this).balance;
    }

    
}