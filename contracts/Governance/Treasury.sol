// SPDX-License-Identifier: GPL-3.0-only
// solhint-disable no-empty-blocks
pragma solidity ^0.7.5;

/// A simple treasury controlled by an admin account.
contract Treasury {
    /// The contract admin.
    address public admin;

    /// Construct a new treasury with an admin.
    constructor(address _admin) {
        admin = _admin;
    }

    /// Withdraw ETH from the treasury.
    function withdraw(address payable recipient, uint256 amount) public {
        require(msg.sender == admin, "Treasury::withdraw: only the admin can withdraw");
        require(amount <= address(this).balance, "Treasury::withdraw: insufficient balance");

        recipient.transfer(amount);
    }

    /// Set a new admin.
    function setAdmin(address _admin) public {
        require(msg.sender == admin, "Treasury::setAdmin: only the admin can set a new admin");
        require(_admin != address(0), "Treasury::setAdmin: admin address cannot be zero");

        admin = _admin;
    }

    /// Receive ETH through here.
    receive() external payable {}
}
