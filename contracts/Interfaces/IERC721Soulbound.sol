// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IERC721Soulbound is IERC721 {

    event Soulbind(uint256 tokenId, uint256 baseTokenId, address claimant);
    function boundTo(uint256 tokenId) external view returns (uint256);
}
