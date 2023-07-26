// Get fund from users
// Withdraw funds
// Set a minimum funding value in USD



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";


error NotOwner();


contract FundMe{
      
      using PriceConverter for uint256;

//  constant  and immutable are gass efficient
// 825702 
// 802778   after using constant

  uint256 public  constant minimumUsd = 5*1e18;

  address[] public funders;
   mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

//    function callMeRight() public{

//    }

address public immutable owner;

constructor(){
    owner = msg.sender;
}

   




 function fund() public payable{
     
     msg.value.getConversionRate();
  require(msg.value.getConversionRate() >= minimumUsd , "did't send enough ETH"); // 1e18 = 1 ETH = 1 = 1000000000000000000 = 1 * 10 ** 18
  
      funders.push(msg.sender);
       addressToAmountFunded[msg.sender] += msg.value;
  
 }



 function withdraw() public onlyOwner {
    
      // require(msg.sender == owner, "Must be owner!");   use this for multiple admins make hard to put this in every, so instead we use modifier -- line no. 86

      for (uint funderIndex=0; funderIndex<funders.length; funderIndex++) {         
          address funder = funders[funderIndex];
          addressToAmountFunded[funder]=0;
      }

     // reset the array

     funders = new address[](0);

    // withdraw funds

    // transfer
    // send
     // call
     
     // msg.sender = address
     // payable(msg.sender) = payable address

 // transfer
    //payable(msg.sender).transfer(address(this).balance);
 
 // send
        // bool sendSuccess =   payable(msg.sender).send(address(this).balance);
        // require(sendSuccess,"Send Failed");

  // call
       (bool callSuccess, ) =payable(msg.sender).call{value: address(this).balance}("");
          require(callSuccess, "Call failed");


 }

    modifier onlyOwner(){
       // require(msg.sender == owner , "Sender is not owner");
       if (msg.sender != owner){revert NotOwner();}  // use less gass
         _;
    }




    // receive()
    // fallback()


     receive() external payable{
           fund();
        }
      

     fallback() external payable{
           fund();
        }

}





