// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CrowdFunding {
    address private owner;
    
    string public id;
    string public name;
    string public description;
    address payable public author;
    string public state = "Opened";
    uint256 public funds;
    uint256 public fundraisingGoal;

    constructor(
        string memory _id,
        string memory _name,
        string memory _description,
        uint256 _fundraisingGoal
    ) {
        id = _id;
        name = _name;
        description = _description;
        fundraisingGoal = _fundraisingGoal;
        author = payable(msg.sender);
        owner = msg.sender;
    }

    function fundProject() public payable {
        author.transfer(msg.value);
        funds += msg.value;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can change the project name");
        //la función es insertada en donde aparece este símbolo
        _;
    }

    function changeProjectState(string calldata newState) public {
        state = newState;
    }
}
