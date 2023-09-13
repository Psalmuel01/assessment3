// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract SimpleVoting {
    // Struct to represent a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store the creator of the contract
    address public owner;

    // Mapping of election ID to Candidate
    mapping(uint => Candidate) public candidates;

    // Mapping of voter addresses to their voted status for a specific election
    mapping(address => mapping(uint => bool)) public hasVoted;

    // Array to store the list of election IDs
    uint[] public electionIds;

    // Constructor to set the contract creator
    constructor() {
        owner = msg.sender;
    }

    // Create a new election
    function createElection(uint electionId) public {
        require(msg.sender == owner, "Only the owner can create elections.");
        require(candidates[electionId].id == 0, "Election ID already exists.");
        electionIds.push(electionId);
    }

    // Add a candidate to an election
    function addCandidate(uint electionId, uint candidateId, string memory name) public {
        require(msg.sender == owner, "Only the owner can add candidates.");
        require(candidates[electionId].id == 0, "Election does not exist.");
        candidates[electionId] = Candidate(candidateId, name, 0);
    }

    // Vote for a candidate in an election
    function vote(uint electionId) public {
        require(candidates[electionId].id != 0, "Election does not exist.");
        require(!hasVoted[msg.sender][electionId], "You have already voted in this election.");

        candidates[electionId].voteCount++;
        hasVoted[msg.sender][electionId] = true;
    }

    // Get the total vote count for a candidate in an election
    function getVoteCount(uint electionId) public view returns (uint) {
        require(candidates[electionId].id != 0, "Election does not exist.");
        return candidates[electionId].voteCount;
    }

    // Get the list of election IDs
    function getElectionIds() public view returns (uint[] memory) {
        return electionIds;
    }
}
