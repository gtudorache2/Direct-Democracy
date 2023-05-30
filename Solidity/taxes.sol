// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import "OpenZeppelin.mod/Strings.sol";
import "OpenZeppelin.mod/math/SafeMath.sol";
import "auth.sol";

contract Taxes {
    Auth auth;
    address private owner;

    struct cCustomTaxesProp {
        string companyID;
        int8 tax;
        int256 votes;
        int256 total;
    }

    struct cProductsProp {
        string productID;
        int8 tax;
        int256 votes;
        int256 total;
    }

    struct cStandardTaxesProp {
        int8 PIT;
        int8 CIT;
        int8 VAT;
        int8 Health;
        int256 votes;
        int256 total;
    }

    struct cVotes {
        address addr;
        int256 vote;
        uint256 id;
    }

    cVotes[] votes;
    cVotes[] customVotes;
    cVotes[] productVotes;

    cCustomTaxesProp[] customTaxesProp;
    cStandardTaxesProp[] standardTaxesProp;
    cProductsProp[] productsTaxesProp;

    constructor(address authAddress) {
        console.log("Owner contract deployed by:", msg.sender);
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor

        standardTaxesProp.push(
            cStandardTaxesProp({
                PIT:16,
                CIT:1,
                VAT:16,
                Health:25,
                votes:0,
                total:0
            })
        );

        auth = Auth(authAddress);
    }

    /**
     * @dev Change owner
     * @param newOwner address of new owner
     */

    /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getOwner() external view returns (address) {
        return owner;
    }

    function proposeStandardTaxes(int8 PIT,int8 CIT,int8 VAT,int8 Health,  bytes32 session) public payable
    {
        auth.checkLogin(session);
        standardTaxesProp.push(
            cStandardTaxesProp({
                PIT:PIT,
                CIT:CIT,
                VAT:VAT,
                Health:Health,
                votes:0,
                total:0
            })
        );
    }


    function proposeCustomTaxes(string memory companyID, int8 tax, bytes32 session) public payable
    {
        auth.checkLogin(session);
        customTaxesProp.push(
            cCustomTaxesProp({
                companyID:companyID,
                tax:tax,
                votes:0,
                total:0
            })
        );
    }

    function proposeProductTaxes(string memory productID, int8 tax,  bytes32 session) public payable
    {
        auth.checkLogin(session);
        productsTaxesProp.push(
            cProductsProp({
                productID:productID,
                tax:tax,
                votes:0,
                total:0
            })
        );
    }

    function getCurrentTaxes() public view returns(cStandardTaxesProp memory taxes)
    {
        int256 max = 0;
        uint256 maxStandard = 0;
        //uint256 maxCustom = 0;

        if (standardTaxesProp.length > 0)
        for(uint256 i = 0; i < standardTaxesProp.length; i++)
        {
            (bool b, int256 percent) = SafeMath.tryDiv(standardTaxesProp[i].votes * 1000, standardTaxesProp[i].total);

            if((b) && (percent >= max))
            {
                max = percent;
                maxStandard = i;
            } 
        }

        max = 0;

        taxes = standardTaxesProp[maxStandard];
    }

    function getCustomTaxes() public view returns(string memory taxes)
    {
        int256 max = 0;

        if (customTaxesProp.length > 0)
        for(uint256 i = 0; i < customTaxesProp.length; i++)
        {
                taxes = string.concat(
                Strings.toString(i),"#",
                customTaxesProp[i].companyID,'#', 
                Strings.toString(customTaxesProp[i].tax),'#',
                Strings.toString(customTaxesProp[i].votes),'#',
                Strings.toString(customTaxesProp[i].total),'|', taxes);
        }

        max = 0;
    }

    function getProductTaxes() public view returns(string memory taxes)
    {
        int256 max = 0;

        if (productsTaxesProp.length > 0)
        for(uint256 i = 0; i < productsTaxesProp.length; i++)
        {
                taxes = string.concat(
                Strings.toString(i),"#",
                productsTaxesProp[i].productID,'#', 
                Strings.toString(productsTaxesProp[i].tax),'#',
                Strings.toString(productsTaxesProp[i].votes),'#',
                Strings.toString(productsTaxesProp[i].total),'|', taxes);
        }

        max = 0;
    }

    function getVotes() public view returns (string memory v) {
        for (uint256 i = 0; i < standardTaxesProp.length; i++)
        {
            v = string.concat(v,
                Strings.toString(int256(standardTaxesProp[i].PIT)), '#',
                Strings.toString(int256(standardTaxesProp[i].CIT)), '#',
                Strings.toString(int256(standardTaxesProp[i].VAT)), '#',
                Strings.toString(int256(standardTaxesProp[i].Health)), '#',
                Strings.toString(int256(standardTaxesProp[i].votes)), '#',
                Strings.toString(standardTaxesProp[i].total), '|'
            );
        }
    }

    function vote(uint256 id, int256 v, bytes32 session) public payable {
        auth.checkLogin(session);        
        require(v >= -1, "Invalid vote");
        require(v <= 1, "Invalid vote");

        if (votes.length > 0)
        for(uint256 i = 0; i < votes.length; i++)
        {
            if (votes[i].addr == msg.sender)
            {
                standardTaxesProp[votes[i].id].votes -= votes[i].vote;
                standardTaxesProp[votes[i].id].total -= 1;
                delete votes[i];
            }
        }
        cVotes memory vot = cVotes({
            addr : msg.sender,
            vote : v,
            id : id
        });
        votes.push(vot);
        standardTaxesProp[id].votes += v;
        standardTaxesProp[id].total += 1;
    }

    function voteCustom(uint256 id, int256 v,  bytes32 session) public payable {
        auth.checkLogin(session);
        require(v >= -1, "Invalid vote");
        require(v <= 1, "Invalid vote");

        if (customVotes.length > 0)
        for(uint256 i = 0; i < customVotes.length; i++)
        {
            if (customVotes[i].addr == msg.sender)
            {
                customTaxesProp[votes[i].id].votes -= customVotes[i].vote;
                customTaxesProp[votes[i].id].total -= 1; 
                delete customVotes[i];
            }
        }
        cVotes memory vot = cVotes({
            addr : msg.sender,
            vote : v,
            id : id
        });
        customVotes.push(vot); 
        customTaxesProp[id].votes += v; 
        customTaxesProp[id].total += 1;
    }

    function voteProduct(uint256 id, int256 v,  bytes32 session) public payable {
        auth.checkLogin(session);
        require(v >= -1, "Invalid vote");
        require(v <= 1, "Invalid vote");

        if (productVotes.length > 0)
        for(uint256 i = 0; i < productVotes.length; i++)
        {
            if (productVotes[i].addr == msg.sender)
            {
                productsTaxesProp[votes[i].id].votes -= productVotes[i].vote;
                productsTaxesProp[votes[i].id].total -= 1; 
                delete productVotes[i];
            }
        }
        cVotes memory vot = cVotes({
            addr : msg.sender,
            vote : v,
            id : id
        });
        productVotes.push(vot); 
        productsTaxesProp[id].votes += v; 
        productsTaxesProp[id].total += 1;
    }

    function getTax(string memory companyID) public view returns(int256)
    {
        int256 tax = 0;
        int256 max = 0;

        for(uint256 i = 0; i < customTaxesProp.length; i++)
        {
            if (keccak256(abi.encodePacked(companyID)) == keccak256(abi.encodePacked(customTaxesProp[i].companyID)))
            {
                  int256 votes2 = customTaxesProp[i].votes*1000/customTaxesProp[i].total;
                  if (votes2 > max)
                    tax = customTaxesProp[i].tax;
            }
        }
     
        return tax;
    }

    function getProductTax(string memory productID) public view returns(int256)
    {
        int256 tax = 0;
        int256 max = 0;

        for(uint256 i = 0; i < productsTaxesProp.length; i++)
        {
            if (keccak256(abi.encodePacked(productID)) == keccak256(abi.encodePacked(productsTaxesProp[i].productID)))
            {
                  int256 votes2 = productsTaxesProp[i].votes*1000/productsTaxesProp[i].total;
                  if (votes2 > max)
                    tax = productsTaxesProp[i].tax;
            }
        }
     
        return tax;
    }
} 