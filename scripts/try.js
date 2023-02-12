// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  const Logic = await hre.ethers.getContractFactory("Logic");
  const RealityETH = await ethers.getContractFactory("RealityETH_v3_0");
  // They want an interface, bytecode
  const realityETH = RealityETH.attach("0x6F80C5cBCF9FbC2dA2F0675E56A5900BB70Df72f"); //ETH Test Net address of RealityETH

  const logic = Logic.attach("0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0");

  //string calldata question, uint32 timeout, uint32 startTimestamp, uint amount
  //logic.declareGoal("Question", 0x1000, Math.round(Date.now() / 1000), 1);
  const [owner] = await ethers.getSigners();
  logic.evaluateGoal(owner.address)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
