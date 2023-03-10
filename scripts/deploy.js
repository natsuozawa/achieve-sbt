// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  const lockedAmount = hre.ethers.utils.parseEther("1");

  const [owner, receiver] = await ethers.getSigners();

  const Logic = await hre.ethers.getContractFactory("Logic");
  const RealityETH = await ethers.getContractFactory("RealityETH_v3_0");
  // They want an interface, bytecode
  const realityETH = RealityETH.attach("0x6F80C5cBCF9FbC2dA2F0675E56A5900BB70Df72f"); //ETH Test Net address of RealityETH

  const logic = await Logic.deploy(realityETH.address);

  await logic.deployed();

  console.log(
    `Achieve SBT Logic side deployed to ${logic.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
