// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract DummyContract2 {
  address public owner;
  uint public value;
  uint public x;
  uint public y;

  constructor(uint _x, uint _y) payable {
    x = _x;
    y = _y;
    owner = msg.sender;
    value = msg.value;
  }
}
