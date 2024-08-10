// SPDX-License-Identifier: MIT
pragma solidity 0.8;

import "erc721a/contracts/ERC721A.sol";


contract PyramidScam is ERC721A{
    address public owner;
    mapping (address => uint) public membersList;
    uint partnerCount = 0;
    

    constructor() ERC721A("Pyramid Scam", "Pym"){
    }

    function mint(address to) public payable {
        require(msg.value > 1, "Insufficient funds");
        _mint(to, 1);
        if (checkIfPartner(to) == true){
        membersList[to] = 0;
        partnerCount = partnerCount + 1;}
    }


    function mintRecruit(address to, address referal) public payable {
        require(msg.value > 1, "Insuffiecent funds");
        require(!checkIfPartner(referal), "Referal address must be partner.");
        require(checkIfPartner(to), "Referalee must not already be partner.");

        _mint(to, 1);
        givenReward(referal);
    }


    function checkIfPartner(address to) public view returns (bool){
        return balanceOf(to) == 0;
    }

    

    function givenReward(address referal) public { 
        uint numberOfReferals = membersList[referal] + 1;
        uint newReferalCount = mintReferalNFT(referal, numberOfReferals);
        membersList[referal] = newReferalCount;

    }

    function mintReferalNFT(address to, uint referal) public payable returns (uint){
        if (referal == 5){
            _mint(to, 1);
            return  0;}
        return referal;
    }
}