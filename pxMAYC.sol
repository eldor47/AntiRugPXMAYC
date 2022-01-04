pragma solidity ^0.8.0;


contract pxMAYC is ERC721Enumerable, Ownable {

    uint256 public pxMAYCPrice = 10000000000000000;
    uint public constant maxpxMAYCPurchase = 10;
    uint public pxMAYCSupply = 6666;
    bool public drop_is_active = false;
    string public baseURI = "https://ipfs.io/ipfs/QmQsTrkFptdGH9SfaLrYixCWBptqME2xqG4dPbQRFF3FuC/";
    uint256 public tokensMinted = 0;
    uint256 public freeMints = 1000;

     mapping(address => uint) addressesThatMinted;

    constructor() ERC721("pxMAYC", "pxMAYC"){
    
    }

    function withdraw() public onlyOwner {
        require(payable(msg.sender).send(address(this).balance));
    }

    function flipDropState() public onlyOwner {
        drop_is_active = !drop_is_active;
    }

    function freeMintpxMAYC(uint numberOfTokens) public {
        require(drop_is_active, "Please wait until the drop is active to mint");
        require(numberOfTokens > 0 && numberOfTokens <= maxpxMAYCPurchase, "Mint count is too little or too high");
        require(tokensMinted + numberOfTokens <= freeMints, "Purchase will exceed max supply of free mints");
        require(addressesThatMinted[msg.sender] + numberOfTokens <= 10, "You have already minted 10!");
        uint256 tokenIndex = tokensMinted;
        tokensMinted += numberOfTokens;
        addressesThatMinted[msg.sender] += numberOfTokens;

        for (uint i = 0; i < numberOfTokens; i++){
            _safeMint(msg.sender, tokenIndex);
            tokenIndex++;
        }
    }

    function mintpxMAYC(uint numberOfTokens) public payable {
        require(drop_is_active, "Please wait until the drop is active to mint");
        require(numberOfTokens > 0 && numberOfTokens <= maxpxMAYCPurchase, "Mint count is too little or too high");
        require(tokensMinted + numberOfTokens <= pxMAYCSupply, "Purchase would exceed max supply of pxMAYC");
        require(msg.value >= pxMAYCPrice * numberOfTokens, "ETH value sent is too little for this many pxMAYC");
        require(addressesThatMinted[msg.sender] + numberOfTokens <= 30, "You have already minted 30!");

        uint256 tokenIndex = tokensMinted;
        tokensMinted += numberOfTokens;
        addressesThatMinted[msg.sender] += numberOfTokens;

        for (uint i = 0; i < numberOfTokens; i++){
            _safeMint(msg.sender, tokenIndex);
            tokenIndex++;
        }
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

      function setpxMAYCPrice(uint256 newpxMAYCPrice)public onlyOwner{
        pxMAYCPrice = newpxMAYCPrice;
    }

      function setBaseURI(string memory newBaseURI)public onlyOwner{
        baseURI = newBaseURI;
    }

    function setSupply(uint256 newSupply)public onlyOwner{
        pxMAYCSupply = newSupply;

    }
    function setFreeMints(uint256 newfreeMints)public onlyOwner{
        freeMints = newfreeMints;


    
    }

}