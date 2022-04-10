// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Deployer {
  event Deployed(address);

  fallback() external payable {}
  receive() external payable {}

  function deploySmartContract(bytes memory _code) external payable returns (address addr) {
    assembly {
      // create(v, p, n)
      // v = amount of ETH to send
      // p = pointer in memory to start of code
      // n = size of code

      // callvalue() == msg.value
      // 0x20 == 32 bytes
      // First 32 bytes have code length
      addr := create(callvalue(),add(_code,0x20),mload(_code))
    }

    require(addr != address(0),"Smart Contract Deployment Failed");

    emit Deployed(addr);
  }

  function executeSmartContract(address _contract,bytes memory _data) external payable {
    (bool success,) = _contract.call{value: msg.value}(_data);
    require(success,"Smart Contract Function Execution Failed");
  }

}
