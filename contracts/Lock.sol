// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "./Interfaces/IRealityETH.sol";

contract Lock {
    uint public unlockTime;
    address payable public owner;
    address payable public receiver;
    IRealityETH realityETHContract;

    mapping(bytes32 => uint) private questionAskedCount;
    mapping(address => bytes32) public questionAskedByUserAddr;

    event Withdrawal(uint amount, uint when);

    // Run at deploy
    constructor(uint _unlockTime, address _receiver, address _realityETHContract) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        unlockTime = _unlockTime;
        owner = payable(msg.sender);
        receiver = payable(_receiver);
        realityETHContract = _realityETHContract;
    }

    function askABoolQuestion(string calldata question, uint32 timeout, uint32 startTimestamp) public {
    // function askQuestion (uint256 template_id, string calldata question, address arbitrator, uint32 timeout, uint32 opening_ts uint256 nonce) external payable returns (bytes32);


        // question_id = keccak256(abi.encodePacked(content_hash, arbitrator, timeout, uint256(0), address(this), msg.sender, nonce));
        bytes32 questionId = realityETHContract.askQuestion(0, question, 0x0, timeout, startTimestamp, questionAskedCount[keccak256(question)]);

        questionAskedByUserAddr[msg.sender] = questionID;
    }


    function validateQuestion(address user) public {
        bytes32 answer = realityETHContract.resultFor(questionAskedByUserAddr[user]);
        if (answer == 0x1) {
            // Some code for SBT
        } else if (answer == 0x0) {
            // Some code to pay out
        } else {
            // Question is not answered yet
            revert("Not answered yet");
        }
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
