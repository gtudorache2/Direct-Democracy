// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
/**
 * @title Owner
 * @dev Set & change owner
 */
contract Taxes {

    address private owner;
  /*  struct cStandardTaxes {
        int256 PIT;
        int256 CIT;
        int256 VAT;
        int256 Health;
    }
    struct cTaxProp {
        int256 value;
        int256 votes;
    }
*/
    struct cCustomProp {
        uint256 companyID;
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

   /* struct cCustomCIT {
        uint256 companyID;
        int8 tax;
    }

    cCustomCIT customCIT;
    cStandardTaxes standardTaxes;
*/
    cCustomProp[] customProp;
    cStandardTaxesProp[] standardTaxesProp;
    // event for EVM logging
    event OwnerSet(address indexed oldOwner, address indexed newOwner);

    // modifier to check if caller is owner
    modifier isOwner() {
        // If the first argument of 'require' evaluates to 'false', execution terminates and all
        // changes to the state and to Ether balances are reverted.
        // This used to consume all gas in old EVM versions, but not anymore.
        // It is often a good idea to use 'require' to check if functions are called correctly.
        // As a second argument, you can also provide an explanation about what went wrong.
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    /**
     * @dev Set contract deployer as owner
     */
    constructor() {
        console.log("Owner contract deployed by:", msg.sender);
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit OwnerSet(address(0), owner);
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
    }

    /**
     * @dev Change owner
     * @param newOwner address of new owner
     */
    function changeOwner(address newOwner) public isOwner {
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }

    /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getOwner() external view returns (address) {
        return owner;
    }

    function proposeStandardTaxes(int8 PIT,int8 CIT,int8 VAT,int8 Health) public payable
    {
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

    function proposeCustomTaxes(uint256 companyID, int8 tax) public payable {
        customProp.push(cCustomProp({
            companyID:companyID,
            tax:tax,
            votes:0,
            total:0
        }));
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

      /*  if (customProp.length > 0)
        for(uint256 i = 0; i < customProp.length; i++)
        {
            (bool b, int256 percent) = SafeMath.tryDiv(customProp[i].votes * 1000, customProp[i].total);

            if((b) && (percent >= max))
            {
                max = percent;
                maxCustom = i;
            } 
        }*/

        taxes = standardTaxesProp[maxStandard];
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

    function vote(uint256 id, int256 v) public payable {
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
} 