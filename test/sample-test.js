const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Deployer Contract", function () {

  it("Deploy DummyContract", async function () {
    let accounts = await ethers.getSigners();

    const DeployerContract = await ethers.getContractFactory("Deployer");
    const deployerContract = await DeployerContract.deploy();
    await deployerContract.deployed();

    const Helper = await ethers.getContractFactory("Helper");
    const helperContract = await Helper.deploy();
    await helperContract.deployed();

    let contractByteCode = await helperContract.getDummyContractByteCode();
    let resultHash = await ((await deployerContract.deploySmartContract(contractByteCode,{ value: 0 })).wait())

    // Checking If Contract Is Created
    let dummyContract = await ethers.getContractAt('DummyContract',resultHash.events[0].args[0])
    await dummyContract.deployed();

    expect(await dummyContract.owner()).to.equal(deployerContract.address);

    // Setting Owner
    let calldata = await helperContract.getDummyContractSetOwnerCallData(accounts[1].address)
    let setOwnerResultHash = await ((await deployerContract.executeSmartContract(dummyContract.address,calldata)).wait())

    expect(await dummyContract.owner()).to.equal(accounts[1].address);
  });

});
