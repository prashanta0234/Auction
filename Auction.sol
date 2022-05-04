// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0<0.9.0;

contract Auction{
    address payable public manager;
    uint public endingTime;
    uint public minimumBid;

    constructor(uint EndingTime,uint MinumumBid){
        manager=payable(msg.sender);
        endingTime=EndingTime;
        minimumBid=MinumumBid;

    }
}