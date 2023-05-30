 // SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "OpenZeppelin.mod/Strings.sol";
import "cypher.sol";

 contract Auth {
    address owner;

    uint8 ACC_PERSONAL = 0;
    uint8 ACC_LIMITED_COMPANY = 1;
    uint8 ACC_SHARE_COMPANY = 2;
    uint8 ACC_INDIVIDUAL_COMPANY = 3;
    uint8 ACC_FOREIGN_BRANCH = 4;
    
    struct person {
        string fullName;
        string SSN;
        string homeAddress;
        string pass;
        string phone;
        uint8 accountType;
        string companyCode;
        address blockAccount;
        bytes32 UID;
        bytes32 session;
    }

    event accountCreated(address UID);
    event loggedIn(bytes32 session);

    uint256 population;
    mapping(address => person) persons;

    constructor() {
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
    }

    function isOwner() internal view
    {
        require(owner == msg.sender, "Not allowed");
    }

    function createAccount(string memory fullName, string memory SSN, string memory homeAddress, string memory pass, uint8 accountType, string memory phone, address addr, string memory companyCode) public payable returns (address)
    {
        isOwner();

        require(accountType <= 5, "Invalid company type");
        require(bytes(SSN).length == 13, string.concat("Invalid SSN : ",SSN));
        require(bytes(fullName).length > 6, "Invalid name");
        require(bytes(homeAddress).length > 10, "Invalid address");
        require(bytes(pass).length > 8, "Password too short");
        require(bytes(phone).length > 6, "Phone number too short");
        address UID = msg.sender;
        bytes32 UID2 = keccak256(abi.encodePacked(string.concat(fullName,SSN,Strings.toString(accountType),homeAddress,pass,phone)));
        //persons.push();
        if (accountType == 0)
        {
            persons[UID] = person({
                fullName : string(cypher.encrypt(bytes(fullName), bytes(pass))),
                SSN : string(cypher.encrypt(bytes(SSN), bytes(pass))),
                homeAddress : string(cypher.encrypt(bytes(homeAddress), bytes(pass))),
                pass : Strings.toHexString(uint256(keccak256(abi.encodePacked(pass)))),
                phone : string(cypher.encrypt(bytes(phone), bytes(pass))),
                accountType: accountType,
                blockAccount : addr,
                UID: UID2,
                companyCode: "0",
                session: keccak256(abi.encodePacked(string.concat(pass,string(abi.encodePacked(UID)), Strings.toString(block.timestamp))))
            });
        }
        else
        {
            persons[UID] = person({
                fullName : fullName,
                SSN : SSN,
                homeAddress : homeAddress,
                pass : pass,
                phone : phone,
                accountType: accountType,
                blockAccount : addr,
                UID: UID2,
                companyCode:companyCode,
                session: keccak256(abi.encodePacked(string.concat(pass,string(abi.encodePacked(UID)), Strings.toString(block.timestamp))))
            });
        }
        population++;
        emit accountCreated(UID);
        return UID;
    }

    function deleteUser(address UID) public payable {
        isOwner();

        delete persons[UID];
        population--;
    }

    function getUser(address UID, string memory pass) public view returns(person memory)
    {
        person memory censoredPerson;


        if (persons[UID].blockAccount != msg.sender)
        {
            censoredPerson = person({
                fullName: "***********",
                SSN : "******",
                homeAddress: "**********",
                pass: "*******",
                phone: "********",
                accountType: persons[UID].accountType,
                blockAccount:msg.sender,
                UID : persons[UID].UID,
                companyCode : persons[UID].companyCode,
                session : "***********"
            });
        }
        else
        {
            censoredPerson = person({
                fullName : string(cypher.encrypt(bytes(persons[UID].fullName), bytes(pass))),
                SSN : string(cypher.encrypt(bytes(persons[UID].SSN), bytes(pass))),
                homeAddress : string(cypher.encrypt(bytes(persons[UID].homeAddress), bytes(pass))),
                pass : "*****",
                phone : string(cypher.encrypt(bytes(persons[UID].phone), bytes(pass))),
                accountType: persons[UID].accountType,
                blockAccount : persons[UID].blockAccount,
                UID: persons[UID].UID,
                companyCode: persons[UID].companyCode,
                session: "************"
            });           
        }

        if (persons[UID].accountType > 0)
        {
            censoredPerson = person({
                fullName: persons[UID].fullName,
                SSN : persons[UID].SSN,
                homeAddress: persons[UID].homeAddress,
                pass: "*******",
                phone: persons[UID].phone,
                accountType: persons[UID].accountType,
                blockAccount:persons[UID].blockAccount,
                UID : persons[UID].UID,
                companyCode: persons[UID].companyCode,
                session: "*************"
            });
        }

        return censoredPerson;
    }

    function editUser(string memory fullName, string memory homeAddress, string memory phone, address blockAccount, string memory companyCode, bytes32 session) public payable
    {
         checkLogin(session);
        address UID = msg.sender;
         if ((persons[UID].blockAccount != msg.sender))    
         {
             persons[UID].fullName = fullName;
             persons[UID].homeAddress = homeAddress;
             persons[UID].phone = phone;
             persons[UID].blockAccount = blockAccount;
             persons[UID].companyCode = companyCode;
         }   
    }

     function compare(string memory str1, string memory str2) private pure returns (bool) {
        return keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2));
    }

    function authenthicate(address UID, string memory pass) public payable returns(bytes32) {
        
        
        require((persons[UID].blockAccount == msg.sender) && (compare(pass, persons[UID].pass)), string.concat("Incorrect password p",persons[UID].pass));

        persons[UID].session = keccak256(abi.encodePacked(string.concat(pass,string(abi.encodePacked(UID)), Strings.toString(block.timestamp))));        
        emit loggedIn(persons[UID].session);
        return persons[UID].session;
    }

    function checkLogin(bytes32 session) public view {
        require(persons[msg.sender].session == session, "Not authenthicated");
    }

    function getPopulation() public view returns (uint256) {
        return population;
    }
 }