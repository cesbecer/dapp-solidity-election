// SPDX-License-Identifier: MIT
pragma solidity >=0.4.2;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Read/write candidates
    mapping(uint => Candidate) public candidates;

    // Store Candidates Count
    uint public candidatesCount;

    // Store accounts that have voted
    mapping(address => bool) public voters;

    // voted event, to trigger an event whenever a vote is cast.
    event votedEvent (
        uint indexed _candidateId
    );


    // Constructor
    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender], "Haven't voted before is required");

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "A valid candidate is required");

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }

}


/*pragma solidity >=0.4.2;

contract Election {
    // Read/write candidate
    string public candidate;

    // Constructor
    constructor() public {
        candidate = "Candidate 1";
    }
}*/