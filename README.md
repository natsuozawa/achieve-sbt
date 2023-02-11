# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```

# Deploying in network

Run the network node:
```
$ npx hardhat node
```

2 options:

1. Run in a local chain

```
$ node scripts/deploy.js
```

2. Run in a local network node

```
$ npx hardhat --network localhost run scripts/deploy.js
```
