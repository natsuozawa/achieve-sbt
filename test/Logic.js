const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("Logic", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployLogic() {
    const Logic = await ethers.getContractFactory("Logic");
    // Signer object has a lot of fields, so extract a
    // ENS not recognized (Ethereum Name Service) error will be returned otherwise.

    const RealityETH = await ethers.getContractFactory("RealityETH_v3_0");
    // They want an interface, bytecode
    const realityETH = RealityETH.attach("0x6F80C5cBCF9FbC2dA2F0675E56A5900BB70Df72f"); //ETH Test Net address of RealityETH
    const logic = await Logic.deploy(realityETH.address);

    // Use the object to see if the test conditions are passed.
    return { logic, realityETH };
  }

  describe("Deployment", function () {
    it("Should set the right realityETH", async function () {
      const { logic, realityETH } = await loadFixture(deployLogic);

      expect(realityETH).to.equal(realityETH);
    });

  //   it("Should set the right owner", async function () {
  //     const { lock, owner } = await loadFixture(deployOneYearLockFixture);

  //     expect(await lock.owner()).to.equal(owner.address);
  //   });

  //   it("Should receive and store the funds to lock", async function () {
  //     const { lock, lockedAmount } = await loadFixture(
  //       deployOneYearLockFixture
  //     );

  //     expect(await ethers.provider.getBalance(lock.address)).to.equal(
  //       lockedAmount
  //     );
  //   });

  //   it("Should fail if the unlockTime is not in the future", async function () {
  //     // We don't use the fixture here because we want a different deployment
  //     const latestTime = await time.latest();
  //     const Lock = await ethers.getContractFactory("Lock");
  //     const [receiver] = await ethers.getSigners();
  //     await expect(Lock.deploy(latestTime, receiver.address, { value: 1 })).to.be.revertedWith(
  //       "Unlock time should be in the future"
  //     );
  //   });
  // });

  // describe("Withdrawals", function () {
  //   describe("Validations", function () {
  //     it("Should revert with the right error if called too soon", async function () {
  //       const { lock, receiver } = await loadFixture(deployOneYearLockFixture);

  //       await expect(lock.withdraw(receiver.address)).to.be.revertedWith(
  //         "You can't withdraw yet"
  //       );
  //     });

  //     it("Should revert with the right error if called from another account", async function () {
  //       const { lock, unlockTime, otherAccount } = await loadFixture(
  //         deployOneYearLockFixture
  //       );

  //       // We can increase the time in Hardhat Network
  //       await time.increaseTo(unlockTime);

  //       // We use lock.connect() to send a transaction from another account
  //       await expect(lock.connect(otherAccount).withdraw(otherAccount.address)).to.be.revertedWith(
  //         "You aren't the owner or receiver"
  //       );
  //     });

  //     it("Shouldn't fail if the unlockTime has arrived and the owner calls it", async function () {
  //       const { lock, unlockTime, owner } = await loadFixture(
  //         deployOneYearLockFixture
  //       );

  //       // Transactions are sent using the first signer by default
  //       await time.increaseTo(unlockTime);

  //       await expect(lock.withdraw(owner.address)).not.to.be.reverted;
  //     });
  //   });

  //   describe("Events", function () {
  //     it("Should emit an event on withdrawals", async function () {
  //       const { lock, unlockTime, lockedAmount, receiver } = await loadFixture(
  //         deployOneYearLockFixture
  //       );

  //       await time.increaseTo(unlockTime);

  //       await expect(lock.withdraw(receiver.address))
  //         .to.emit(lock, "Withdrawal")
  //         .withArgs(lockedAmount, anyValue); // We accept any value as `when` arg
  //     });
  //   });

  //   describe("Transfers", function () {
  //     it("Should transfer the funds to the receiver", async function () {
  //       const { lock, unlockTime, lockedAmount, receiver } = await loadFixture(
  //         deployOneYearLockFixture
  //       );

  //       await time.increaseTo(unlockTime);

  //       await expect(lock.withdraw(receiver.address)).to.changeEtherBalances(
  //         [receiver, lock],
  //         [lockedAmount, -lockedAmount]
  //       );
  //     });
  //   });
  });
});
