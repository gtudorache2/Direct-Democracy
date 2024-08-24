// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "hardhat/console.sol";
import "./OpenZeppelin.mod/Strings.sol";
import "./OpenZeppelin.mod/math/SafeMath.sol";

contract users {
    address owner = msg.sender;
    struct person {
        string name;
        uint256 code;
        string homeAddress;
        string phoneNumber;
        string photo;
        uint64 dateOfBirth;
        string city;
        address addedBy;
        string idNumber;
        uint64 idExpiration;
        string[] citizenships;
        address[] jobs;
        bool verified;
    }

    mapping(address => person) workers;
    mapping(address => person) public persons;

    function isActive(address user) public view returns(bool) {
        return persons[user].verified;
    }
    function addPerson(address personAddress, person memory user) public payable {
        require(msg.value > 0, "NO_MONEY");
        require(!(Strings.equal(user.name, '')), "INVALID_NAME");
        require(!(Strings.equal(user.homeAddress, '')), "INVALID_ADDRESS");
        require(!(Strings.equal(user.photo, '')), "INVALID_PHOTO");
        require(!(Strings.equal(user.city, '')), "INVALID_CITY");
        require(!(Strings.equal(user.idNumber, '')), "INVALID_ID_NUMBER");
        require(user.citizenships.length > 0, "INVALID_CITIZENSHIPS");
        user.verified = false;
        persons[personAddress] = user;
    }

    function verifyPerson(address personAddress) public {
        if(workers[msg.sender].verified) {
            persons[personAddress].verified = true;
        }
    }

    function addWorker(address personAddress) public {
        require(persons[personAddress].verified, "NOT_A_CITIZEN");
        require(((workers[msg.sender].verified) || (owner == msg.sender)), "NOT_A_WORKER");

        workers[personAddress] = persons[personAddress];
    }

    function removeWorker(address personAddress) public {
        require(persons[personAddress].verified, "NOT_A_CITIZEN");
        require(((workers[msg.sender].verified) || (owner == msg.sender)), "NOT_A_WORKER");

        delete(workers[personAddress]);
    }

    function removePerson(address personAddress) public {
        require(persons[personAddress].verified, "NOT_A_CITIZEN");
        require(((workers[msg.sender].verified) || (owner == msg.sender)), "NOT_A_WORKER");

        delete(persons[personAddress]);
    }    
}