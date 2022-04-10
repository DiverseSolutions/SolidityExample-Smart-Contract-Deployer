const hre = require("hardhat");

async function main() {
  const DeployerContract = await hre.ethers.getContractFactory("Deployer");
  const contract = await DeployerContract.deploy();

  await contract.deployed();

  console.log("Deployer Contract deployed to:", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
