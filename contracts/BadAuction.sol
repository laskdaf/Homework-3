pragma solidity ^0.4.15;

import "./AuctionInterface.sol";

/** @title BadAuction */
contract BadAuction is AuctionInterface {
	/* Bid function, vulnerable to attack
	 * Must return true on successful send and/or bid,
	 * bidder reassignment
	 * Must return false on failure and send people
	 * their funds back
	 */

	bool poisoned = false;

	function bid() payable external returns (bool) {
		if (poisoned) {
			return false;
		}
		// YOUR CODE HERE
		if (msg.value <= highestBid) {
			if (!msg.sender.send(msg.value)) {
				throw;
			}
			if (msg.value > this.balance) {
				poisoned = true;
				return false;
			}
			return false;
		}

		if (!highestBidder.send(highestBid)) {
			throw;
		}

		highestBidder = msg.sender;
		highestBid = msg.value;
	}

	/* Give people their funds back */
	function () payable {
		// YOUR CODE HERE
	}
}
