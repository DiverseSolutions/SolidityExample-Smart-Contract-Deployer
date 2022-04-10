// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract DummyContract {
  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function setOwner(address _owner) public {
    require(msg.sender == owner, "Not Smart Contract Owner");
    owner = _owner;
  }
}
