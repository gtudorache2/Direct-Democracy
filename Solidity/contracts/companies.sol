// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "hardhat/console.sol";
import "./OpenZeppelin.mod/Strings.sol";
import "./OpenZeppelin.mod/math/SafeMath.sol";
import "./users.sol";
import "./currency.sol";
contract companies {
    address owner = msg.sender;
    struct shares {
        address person;
        int8 shares;
    }

    struct employee {
        address person;
        uint256 salary;
        uint64 paymentDate;
        string jobDescription;
    }

    struct company {
        string name;
        string[] caen;
        string streetAddress;
        string phoneNumber;
        address owner;
        string description;
        string logo;
        bool verified;
    }

    mapping(address => company) companies;
    mapping(address => shares[]) shareHolders;
    mapping(address => employee[]) employees;
    address _personsContract;
    address _tokensContract;

    constructor(address personsContract, address tokensContract) {
        _personsContract = personsContract;
        _tokensContract = tokensContract;
    }

    function addCompany(company memory c, shares[] memory s, employee[] memory e) public payable {
        require(!(Strings.equal(c.name, '')), "INVALID_NAME");
        require(!(Strings.equal(c.streetAddress, '')), "INVALID_ADDRESS");
        require(!(Strings.equal(c.phoneNumber, '')), "INVALID_NUMBER");
        require(c.caen.length > 0, "INVALID_CAENS");
        require(s.length > 0, "INVALID_CAENS");
        require(msg.value > 0, "COMPANY_TAX_INVALID"); 
        require(users(_personsContract).isActive(msg.sender), "NOT_A_CITIZEN");

        shareHolders[msg.sender] = s;
        employees[msg.sender] = e;
        companies[msg.sender] = c;
    }

   function deleteCompany(address addr) public {
        require(owner == msg.sender, "NO_PERMISSIONS");

        delete(companies[addr]);
   }

   function addEmployee(address employee1, employee memory e) public {
        require(users(_personsContract).isActive(employee1), "NOT_A_CITIZEN");   
        require(msg.sender == companies[msg.sender].owner, "NOT_THE_OWNER");
        require(companies[msg.sender].verified, "INACTIVE_COMPANY");
        employees[msg.sender].push(e);        
   }    

   function deleteEmployee(uint256 id) public {
        require(msg.sender == companies[msg.sender].owner, "NOT_THE_OWNER");
        require(companies[msg.sender].verified, "INACTIVE_COMPANY");
        delete(employees[msg.sender][id]);        
   }

   function paySalaries() public {
        require(msg.sender == companies[msg.sender].owner, "NOT_THE_OWNER");
        require(companies[msg.sender].verified, "INACTIVE_COMPANY");

        for(uint256 i = 0; i < employees[msg.sender].length; i++) {   
            ERC20(_tokensContract).transfer(employees[msg.sender][i].person, employees[msg.sender][i].salary);
        }
    }

      function withdrawDividends(address company1, uint256 amount) public {
        require(companies[msg.sender].verified, "INACTIVE_COMPANY");
        require(companies[company1].verified, "INACTIVE_COMPANY");

        for(uint256 i = 0; i < shareHolders[company1].length; i++) { 
            if (shareHolders[company][i].person == msg.sender) { 
                uint256 shares = shareHolders[company][i].share * ERC20(_tokensContract).getBalance(company1) / 100;
                if(amount <= shares)
                    ERC20(_tokensContract).transferFrom(company, shareHolders[company][i].person, employees[msg.sender][i].salary);
                break;
            }
        }
   }
}