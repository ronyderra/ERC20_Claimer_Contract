// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Claim is Ownable {

 uint256 public totalAmount;
 mapping(address => uint256) public deposits;
 ERC20 public token;

    constructor(address _address) {
       token = ERC20(_address);
    }

    function deposit(uint256 _amount) public {
        require(token.balanceOf(msg.sender) >= _amount , "You do not have the amount");
        deposits[msg.sender] += _amount;
        totalAmount += _amount;
        token.transferFrom(msg.sender , address(this) , _amount);
    }

    function claim() public {
        require(deposits[msg.sender] > 0 , "There are no funds");
        totalAmount -= deposits[msg.sender];
        token.transfer(msg.sender , deposits[msg.sender]);
        delete deposits[msg.sender];
    }

    function withdraw() public onlyOwner {
      token.transfer( msg.sender , totalAmount);
    }
}