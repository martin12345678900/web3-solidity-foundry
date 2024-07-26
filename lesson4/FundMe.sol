// Get funds from users
// Widthdraw funds
// Set a minimum function value in USD

// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import { PriceConverter } from "./PriceConverter.sol";

// We have imported the intreface from chailink which when it's compiled it gives us the ABI
// Having and ABI and address of the contract we can interact with the functions declared on this contract

error NotOwner();

contract FundMe {

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5 * 1e18;
    
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    address[] public funders;
    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        // Allow users to send $ having a minimumUSD of 5$
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough ETH"); // 1e18 = 1 ETH

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funderAddress = funders[funderIndex];
            addressToAmountFunded[funderAddress] = 0;
        }

        funders = new address[](0);

        // msg.sender = address
        // payable(msg.sender) = payable address
        (bool callSuccess, ) = payable(msg.sender).call{ value: address(this).balance }("");
        require(callSuccess, "Call failed");
    }
    
    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not the owner");
        if (msg.sender != i_owner) {
            revert NotOwner();
        } 
        _;
        // U can have more logic after the function is executed
    }

    // Receive and fallback are executed if someone calls the contract with some ETH without calling directly the fund function
    receive() external payable { 
        fund();   
    }

    fallback() external payable { 
        fund();
    }
}