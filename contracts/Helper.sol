// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./DummyContract.sol";
import "./DummyContract2.sol";

contract Helper {
  function getDummyContractByteCode() external pure returns (bytes memory) {
    bytes memory bytecode = type(DummyContract).creationCode;
    return bytecode;
  }

  function getDummyContract2ByteCode(uint _x, uint _y) external pure returns (bytes memory) {
    bytes memory bytecode = type(DummyContract2).creationCode;
    return abi.encodePacked(bytecode,abi.encode(_x,_y));
  }

  function getDummyContractSetOwnerCallData(address _owner) external pure returns (bytes memory) {
    return abi.encodeWithSignature("setOwner(address)",_owner);
  }
}
