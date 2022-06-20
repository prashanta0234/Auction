// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0<0.9.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe{
    uint public minimumValue=2*1e18;
    function Fund() public payable{
        require(getConverstion(msg.value) >minimumValue,"Please send more big value");
    }

    function getPrice() public view returns(uint) {
        // adress: 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int price,,,)=priceFeed.latestRoundData();
        return uint(price*1e10);
    }
    function getConverstion(uint amount) public view returns(uint) {
        uint price=getPrice();
        uint priceUsd=(price*amount)/1e18;
        return priceUsd;
    }
}