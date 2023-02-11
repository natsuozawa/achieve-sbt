// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {
    IERC721,
    ERC721
} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {IERC721Soulbound} from "../Interfaces/IERC721Soulbound.sol";

abstract contract ERC721Soulbound is ERC721, IERC721Soulbound {
    // tokenId => soulId (a soulId MAY bind with many tokenIds)
    mapping(uint256 => uint256) private _boundTo;

    constructor(
        string memory name_,
        string memory symbol_
    ) ERC721(name_, symbol_) {}


    function boundTo(uint256 tokenId) public virtual override view returns (uint256) {
        return _boundTo[tokenId];
    }

    function _soulbind(
        uint256 soulId,
        address claimant,
        uint256 tokenId
    ) internal virtual {
        emit Soulbind(tokenId, soulId, claimant);
        _boundTo[tokenId] = soulId;

        _safeMint(claimant, tokenId);
    }

}
