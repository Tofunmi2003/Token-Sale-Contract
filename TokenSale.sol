// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        _mint(msg.sender, initialSupply);
    }
}

contract TokenSale {
    MyToken public token;
    uint public price; // Price per token
    address public owner;

    event TokenPurchased(address indexed buyer, uint256 amount);

    constructor(MyToken _token, uint256 _price) {
        token = _token;
        price = _price;
        owner = msg.sender;
    }

    function buyTokens(uint256 numberOfTokens) public payable {
        require(msg.value >= numberOfTokens * price, "Not enough ether sent");

        // Transfer tokens to the buyer
        token.transfer(msg.sender, numberOfTokens);

        // Transfer funds to the owner
        payable(owner).transfer(msg.value);

        emit TokenPurchased(msg.sender, numberOfTokens);
    }
}