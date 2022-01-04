pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract pxMAYC is IERC721, ERC721Enumerable, Ownable {
    
    uint public pxMAYCSupply = 6666;
    bool public drop_is_active = false;
    string public baseURI = "WILLNEEDTOBESETONCEWEGETTHISINFORMATION";
    uint256 public tokensMinted = 0;

    IERC721 public rugToken;
    bool[6666] public rugTokenMintStatus;

    constructor(IERC721 _rugToken) ERC721("pxMAYC", "pxMAYC"){
        rugToken = _rugToken;
        for(uint256 i = 0; i < pxMAYCSupply; i++) {
            rugTokenMintStatus[i] = false;
        }
    }

    function withdraw() public onlyOwner {
        require(payable(msg.sender).send(address(this).balance));
    }

    function flipDropState() public onlyOwner {
        drop_is_active = !drop_is_active;
    }

    function freeMintpxMAYC(address _to, uint[] calldata tokenIds) public {
        require(tx.origin == msg.sender);
        require(drop_is_active, "Please wait until the drop is active to mint");

        for (uint256 i = 0; i < tokenIds.length; i++) {
            uint256 tokenId = tokenIds[i];
            require(rugToken.ownerOf(tokenId) == msg.sender, "You do not own all of these apes.");
            require(rugTokenMintStatus[tokenId] == false, "Token(s) already minted");
        }

        for (uint256 i = 0; i < tokenIds.length; i++) {
            uint256 tokenId = tokenIds[i];
            _safeMint(_to, tokenId);
        }
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory newBaseURI)public onlyOwner{
        baseURI = newBaseURI;
    }


}