pragma solidity 0.5.1;

import "./Ownable.sol";


/// @title Whitelist
/// @author STOKR
contract Whitelist is Ownable {

    // Set of Whitelisted addresses
    mapping(address => bool) public isWhitelisted;

    /// @dev Log entry on investor added set
    /// @param admin An Ethereum address
    /// @param investor An Ethereum address
    event InvestorAdded(address indexed admin, address indexed investor);

    /// @dev Log entry on investor removed from set
    /// @param admin An Ethereum address
    /// @param investor An Ethereum address
    event InvestorRemoved(address indexed admin, address indexed investor);

    constructor() public {}

    /// @dev Add investor to set of whitelisted addresses
    /// @param _investors A list where each entry is an Ethereum address
    function addToWhitelist(address[] calldata _investors) external onlyOwner {
        for (uint256 i = 0; i < _investors.length; i++) {
            if (!isWhitelisted[_investors[i]]) {
                isWhitelisted[_investors[i]] = true;

                emit InvestorAdded(msg.sender, _investors[i]);
            }
        }
    }

    /// @dev Remove investor from set of whitelisted addresses
    /// @param _investors A list where each entry is an Ethereum address
    function removeFromWhitelist(address[] calldata _investors) external onlyOwner
     {
        for (uint256 i = 0; i < _investors.length; i++) {
            if (isWhitelisted[_investors[i]]) {
                isWhitelisted[_investors[i]] = false;

                emit InvestorRemoved(msg.sender, _investors[i]);
            }
        }
    }

}
