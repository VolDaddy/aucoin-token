// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAuCoin {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract ClaimAuCoin {
    address public owner;
    IAuCoin public auCoin;

    mapping(address => bool) public hasClaimed;

    event TokensClaimed(address indexed user, uint256 amount);

    constructor(address _tokenAddress) {
        owner = msg.sender;
        auCoin = IAuCoin(_tokenAddress);
    }

    function claim() external {
        require(!hasClaimed[msg.sender], "Already claimed");
        hasClaimed[msg.sender] = true;
        uint256 amount = 100 * 10**18;
        require(auCoin.transfer(msg.sender, amount), "Transfer failed");
        emit TokensClaimed(msg.sender, amount);
    }
}
