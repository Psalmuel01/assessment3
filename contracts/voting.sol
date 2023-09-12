// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Voting {

    //struct to represent a candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // store the creator of the contract
    address public owner;

    // map electionID to Candidate
    mapping(uint => Candidate) public candidates;

    // mapping voter addresses to their voting status for a specific election
    mapping(address => mapping(uint => bool)) public hasVoted;

    // array to store the list of election ids
    uint public electionIds;
}