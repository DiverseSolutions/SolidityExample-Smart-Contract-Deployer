// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/// @title Smart Contract to Deploy Smart Contract From Smart Contract ByteCode
/// @author mnkhod
/// @notice Uses solidity assembly create(v,p,n) to create Smart Contract with byteCode
contract Deployer {

  /// @notice used to get addresses that have been deployed with deploySmartContract()
  event Deployed(address);

  /// @notice just in case network currency gets stuck inside smart contract
  fallback() external payable {}

  /// @notice just in case network currency gets stuck inside smart contract
  receive() external payable {}

  /// @notice main function to deploy smart contract with byte code
  /// @param _code needs smart contract bytecode to deploy
  /// @return addr returns the deployed smart contract address
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

  /// @notice function used to execute smart contract functionality from this contract
  /// @param _contract target smart contract address
  /// @param _data the compiled data of the functionality signature with the needed data for params and such
  function executeSmartContract(address _contract,bytes memory _data) external payable {
    (bool success,) = _contract.call{value: msg.value}(_data);
    require(success,"Smart Contract Function Execution Failed");
  }

}
