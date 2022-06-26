// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.2; 

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract XborgSoulbound is ERC721URIStorage {
    address owner;
    string URI;

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    constructor() ERC721("Soulbound token", "XBORG SBT") {
    owner = msg.sender;

    }
    mapping(address => bool) public issuedSBTs;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function issueSBT(address to) external onlyOwner{
        issuedSBTs[to] = true;
    }

    function claimSBT () public returns(uint256){
        require(issuedSBTs[msg.sender], "Not qualified for SBTs");
        URI = "";

        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, URI);

        personToSBT[msg.sender] = URI; 
        issuedSBTs[msg.sender] = false; 

        return newItemId; 
    }

      function airdrop (address airdropadress) external onlyOwner returns(uint256){
        URI = "";
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(airdropadress, newItemId);
        _setTokenURI(newItemId, URI);

        return newItemId;
    }

    mapping (address => string) public personToSBT;

}
