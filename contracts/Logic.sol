// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";

import "./Interfaces/IRealityETH.sol";

contract Logic {
    IRealityETH realityETHContract;

    mapping(bytes32 => uint) private questionAskedCount; // Necessary to ensure uniqueness of hash
    mapping(address => bytes32) public questionAskedByUserAddr; // MVP 1 user to 1 question mapping
    mapping(address => uint) public depositByUserAddr; // MVP 1 user to 1 deposit amount mapping

    event Withdrawal(uint amount, uint when);

    // Run at deploy
    constructor(address _realityETHContract) payable {
        realityETHContract = IRealityETH(_realityETHContract);
        console.log("Deploy successful");
    }

    // Frontend calls this function every time a new question is asked.
    // timeout: time from startTimestamp to close the question. Sanity checked at 365 days+.
    // startTimestamp: when the question will be roughly validated.
    function declareGoal(string calldata question, uint32 timeout, uint32 startTimestamp) payable public {
        require(block.timestamp < startTimestamp, "start timestamp should happen after current time");
        //require(questionAskedByUserAddr[msg.sender] == 0x0, "user can only ask one active question");
        bytes32 questionId = realityETHContract.askQuestion(0, question, address(0x0), timeout, startTimestamp, 0);//
        questionAskedCount[keccak256(abi.encodePacked((question)))] += 1;
        questionAskedByUserAddr[msg.sender] = questionId;

        emit Withdrawal(msg.value, block.timestamp);
        depositByUserAddr[msg.sender] = msg.value;
    }

    // Copied from original contract of RealityETH
    // function askQuestion (uint256 template_id, string calldata question, address arbitrator, uint32 timeout, uint32 opening_ts uint256 nonce) external payable returns (bytes32);
        // question_id = keccak256(abi.encodePacked(content_hash, arbitrator, timeout, uint256(0), address(this), msg.sender, nonce));

    // After declareGoal has been called and timeout time has passed, run this function either manually or by using an alarm clock oracle.
    function evaluateGoal(address user) public {
        require(questionAskedByUserAddr[user] > 0, "User has no goal declared");
        uint256 answer = uint256(realityETHContract.resultFor(questionAskedByUserAddr[user]));
        if (answer == 0x1) {
            // Some code for SBT
            // Pay back
            console.log("Issue SBT");
            emit Withdrawal(depositByUserAddr[user], block.timestamp);
            payable(user).transfer(depositByUserAddr[user]);
            depositByUserAddr[user] = 0;
            questionAskedByUserAddr[user] = 0x0;
        } else if (answer == 0x0) {
            // Pool money : do nothing
            // TODO: buy climate token? or play around
            depositByUserAddr[user] = 0;
            questionAskedByUserAddr[user] = 0x0;
        } else {
            // Question is not answered yet
            // Ask later
            revert("Not answered yet");
        }
    }
}
