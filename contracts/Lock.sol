// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "./Interfaces/IRealityETH.sol";

contract Lock {
    uint public unlockTime;
    IRealityETH realityETHContract;

    mapping(bytes32 => uint) private questionAskedCount;
    mapping(address => bytes32) public questionAskedByUserAddr; // MVP

    event Withdrawal(uint amount, uint when);

    // Run at deploy
    constructor(address _realityETHContract) payable {
        realityETHContract = _realityETHContract;
    }

    // Frontend calls this function every time a new question is asked.
    function askABoolQuestion(string calldata question, uint32 timeout, uint32 startTimestamp) public {
        require(timeout > block.timestamp, "Timeout should happen after current time");
    // function askQuestion (uint256 template_id, string calldata question, address arbitrator, uint32 timeout, uint32 opening_ts uint256 nonce) external payable returns (bytes32);
        // question_id = keccak256(abi.encodePacked(content_hash, arbitrator, timeout, uint256(0), address(this), msg.sender, nonce));
        bytes32 questionId = realityETHContract.askQuestion(0, question, 0x0, timeout, startTimestamp, questionAskedCount[keccak256(question)]);
        questionAskedByUserAddr[msg.sender] = questionID;
    }

    function validateQuestion(address user) public {
        bytes32 answer = realityETHContract.resultFor(questionAskedByUserAddr[user]);
        if (answer == 0x1) {
            // Some code for SBT
            // Pay back
            emit Withdrawal(address(this).balance, block.timestamp);
            payable(user).transfer(address(this).balance);
        } else if (answer == 0x0) {
            // Some code to pay out
            // TODO: find out a way to pay people for this. Is this already done?
        } else {
            // Question is not answered yet
            revert("Not answered yet");
        }
    }
}
