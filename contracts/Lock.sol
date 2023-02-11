// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Lock {
    uint public unlockTime;
    address payable public owner;
    address payable public receiver;

    event Withdrawal(uint amount, uint when);

    // Run at deploy
    constructor(uint _unlockTime, address _receiver) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        unlockTime = _unlockTime;
        owner = payable(msg.sender);
        receiver = payable(_receiver);
    }

    // Public function: anyone can call it anytime, so we have to catch it
    function withdraw(address to) public {
        // Uncomment this line, and the import of "hardhat/console.sol", to print a log in your terminal
        // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner || msg.sender == receiver, "You aren't the owner or receiver");

        emit Withdrawal(address(this).balance, block.timestamp);

        payable(to).transfer(address(this).balance);
    }
}
