// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Claim is Ownable {

 mapping(address => uint256) public deposits;
 ERC20 public token;

    constructor(address _address) {
       token = ERC20(_address);
    }

    function deposit(uint256 _amount) external {
        require(token.balanceOf(msg.sender) >= _amount , "You do not have the amount");
        deposits[msg.sender] += _amount;
    }

    function claim() external {
        require(deposits[msg.sender] > 0 , "There are no funds");
        token.transfer(msg.sender , deposits[msg.sender]);
        delete deposits[msg.sender];
    }

    function withdraw(uint256 _totalAmount) external onlyOwner {
      token.transfer( msg.sender , _totalAmount);
    }
}