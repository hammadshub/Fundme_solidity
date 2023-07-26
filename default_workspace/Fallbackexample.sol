// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;



contract Fallbackexample{
    uint public result;
        receive() external payable{
            result = 1;
        }
}