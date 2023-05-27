// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "OpenZeppelin.mod/Strings.sol";
import "auth.sol";

 contract Accounting {
    
    Auth auth;
    struct cProduct {
        uint256 id;
        string name;
        uint256 quantity;
        string category;
        uint256 barcode;
        bool allowed;
    }

    struct cInOut {
        cProduct product;
        int256 value;
        int256 price;
        int256 quantity;
        uint256 timestamp;
    }

    cProduct[] productsList;
    mapping(bytes32 => cInOut[]) accounts;

    constructor(address authAddress) {
        auth = Auth(authAddress);
    }

    function createProduct(uint256 id, string memory name, uint256 quantity, uint256 barcode, string memory category,bool allowed) public payable {
        productsList.push();
        productsList[productsList.length-1] = cProduct({
            id:id,
            name:name,
            quantity:quantity,
            category:category,
            barcode:barcode,
            allowed:allowed        
        });
    }
    
    function addToStock(bytes32 UID, string memory pass, uint256 productId, uint256 quantity, int256 value, int256 price) public payable {
        require(auth.authenthicate(UID, pass), "Please log in");
        
        accounts[UID].push();
        accounts[UID][accounts[UID].length-1] = cInOut({
            product:productsList[productId],
            value:value,
            price:price,
            quantity:int256(quantity),
            timestamp:block.timestamp
        });
    }

    function removeFromStock(bytes32 UID, string memory pass, uint256 productId, uint256 quantity, int256 value, int256 price) public payable {
        require(auth.authenthicate(UID, pass), "Please log in");
        accounts[UID].push();
        accounts[UID][accounts[UID].length-1] = cInOut({
            product:productsList[productId],
            value:value,
            price:price,
            quantity:-int256(quantity),
            timestamp:block.timestamp
        });
    }

    function getStockByBarcode(bytes32 UID, string memory pass, uint256 barcode) public view returns(int256 stock)
    {
        require(auth.authenthicate(UID, pass), "Please log in");

        stock = 0;

        for(uint256 i; i < accounts[UID].length; i++)
        {
            if (barcode == accounts[UID][i].product.barcode) {
                stock += accounts[UID][i].quantity;
            }
        }        
    }

    function getStockById(bytes32 UID, string memory pass, uint256 id) public view returns(int256 stock)
    {
        require(auth.authenthicate(UID, pass), "Please log in");

        stock = 0;

        for(uint256 i; i < accounts[UID].length; i++)
        {
            if (id == accounts[UID][i].product.id) {
                stock += accounts[UID][i].quantity;
            }
        }        
    }

    function getInOuts(bytes32 UID, string memory pass, uint256 from, uint256 to) public view returns(string memory acc)
    {
         require(auth.authenthicate(UID, pass), "Please log in");

        for(uint256 i; i < accounts[UID].length; i++)
        {
            if ((accounts[UID][i].timestamp >= from) && (accounts[UID][i].timestamp <= to))
            acc = string.concat(Strings.toString(accounts[UID][i].product.id), "#", accounts[UID][i].product.name,"#",
            Strings.toString(accounts[UID][i].quantity),"#", Strings.toString(accounts[UID][i].value), "#",
            Strings.toString(accounts[UID][i].price), "#", Strings.toString(accounts[UID][i].timestamp), "|", acc);
        }
    }

    function getProduct(uint256 id) public view returns (cProduct memory)
    {
        return productsList[id];
    }
 }