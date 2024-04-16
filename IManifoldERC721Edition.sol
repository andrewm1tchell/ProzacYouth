// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @author: manifold.xyz

/**
 * Manifold ERC721 Edition Controller interface
 */
interface IManifoldERC721Edition {
    /**
     * @dev Mint NFTs to a single recipient
     */
    function mint(address recipient) external payable;

    /**
     * @dev Total supply of editions
     */
    function totalSupply() external view returns(uint256);

    /**
     * @dev Max supply of editions
     */
    function maxSupply() external view returns(uint256);
}