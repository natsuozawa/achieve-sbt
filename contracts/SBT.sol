// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.7;

// import {
//     ERC721,
//     ERC721Enumerable
// } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
// import {ERC721Burnable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
// import {ERC721Soulbound} from "./utils/ERC721Soulbound.sol";
// // where did this go??

// contract SBT is
//     ERC721Soulbound,
//     ERC721Enumerable,
//     ERC721Burnable
// {
//     address private constant _COVEN = 0x5180db8F5c931aaE63c74266b211F580155ecac8;
//     string private constant _SYMBOL = "SPELLBOUND";
//     string private constant _NAME = "Spells soulbound to Crypto Coven witches";
//     uint256 public constant PRICE = 1;
//     address LOCK_CONTRACT;

//     mapping(uint256 => bytes) public spell;

//     constructor(address _lock_contract) ERC721Soulbound(_NAME, _SYMBOL) {
//       LOCK_CONTRACT = _lock_contract;
//     } // solhint-disable-line no-empty-blocks

//     function mint(uint256 witchId, string[3] memory spellLines) external payable {
//         require(msg.sender == LOCK_CONTRACT, "can only be minted by lock contract");


//         _soulbind(witchId, msg.sender, totalSupply() + 1);
//     }

//     function burn(uint256 tokenId) public virtual override {
//         // require(soulOwner(tokenId) == msg.sender, "Spellbound: only soulOwner can release spell");
//         // ERC721Burnable.burn(tokenId);
//     }

//     function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
//       // Return image of the sbt here
//       // string.concat('{\"name\":', name, \"description\":', description........
//     }

//     function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721Enumerable, ERC721) returns (bool) {
//         return ERC721Enumerable.supportsInterface(interfaceId);
//     }

//     function _beforeTokenTransfer(
//         address from,
//         address to,
//         uint256 tokenId
//     ) internal virtual override(ERC721Enumerable, ERC721) {
//         ERC721Enumerable._beforeTokenTransfer(from, to, tokenId);
//     }
// }
