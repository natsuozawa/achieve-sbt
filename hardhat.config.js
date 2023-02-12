require("@nomicfoundation/hardhat-toolbox");

PRIVATE_KEY = "0x4f6474b74c8858db710952488719243ed1172ae2eb339d16538b42d638964ccb";

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    hardhat: {
    },
    goerli: {
      url: "https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
      accounts: [PRIVATE_KEY]
    }
  },
};
