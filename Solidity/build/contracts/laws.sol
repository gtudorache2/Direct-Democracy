// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "hardhat/console.sol";
import "./OpenZeppelin.mod/Strings.sol";
import "./OpenZeppelin.mod/math/SafeMath.sol";
import "./currency.sol";
import "./users.sol";
/**
 * @title Owner
 * @dev Set & change owner
 */
contract Laws {

    address private owner;

    struct cLaws {
        string title;
        string law;
        string[] articles;
        string[] documents;
        int256 votes;
        uint256 total;
        uint256 version;
    }

    struct cVote {
        address addr;
        uint256 version;
        int256 vote;
    }

    cVote[][] votes;
    cLaws[][] laws;

    uint256 lawIndex = 0;
    // event for EVM logging
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    event LawCreated(uint256 indexed id);
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

    address _personsContract;
    address _tokensContract;

    constructor(address personsContract, address tokensContract) {
        console.log("Owner contract deployed by:", msg.sender);
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit OwnerSet(address(0), owner);
        _personsContract = personsContract;
        _tokensContract = tokensContract;
    }

    /**
     * @dev Change owner
     * @param newOwner address of new owner
     */
    function changeOwner(address newOwner) public isOwner {
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }


    function createLaw(string memory title, string memory law, string[] memory articles, string[] memory documents) public payable returns (uint256) {
        require(users(_personsContract).isActive(msg.sender), "NOT_A_CITIZEN");        
        require(bytes(law).length > 10, "Text to small");
        require(bytes(title).length > 4, "Text too small");

        cLaws memory Law = cLaws({
            title:title,
            law:law,
            articles:articles,
            documents:documents,
            votes:0,
            total:0,
            version:block.timestamp
            });
        laws.push();
        laws[laws.length-1].push(Law);
        lawIndex++;
        votes.push();
        emit LawCreated(laws.length-1);
        return laws.length-1;
    }

    function proposeEdit(uint256 id, string memory law, string[] memory articles, string[] memory documents) public payable {
        require(users(_personsContract).isActive(msg.sender), "NOT_A_CITIZEN");
         cLaws memory Law = cLaws({
            title:laws[id][0].title,
            law:law,
            articles:articles,
            documents:documents,
            votes:0,
            total:0,
            version:block.timestamp
            });
        laws[id].push(Law);
    }

    function proposeArticleEdit(uint256 id, uint256 articleId, uint256 version, string memory article) public payable {
        require(users(_personsContract).isActive(msg.sender), "NOT_A_CITIZEN");
         cLaws memory Law = cLaws({
            title:laws[id][version].title,
            law: laws[id][version].law,
            articles:laws[id][version].articles,
            documents:laws[id][version].documents,
            votes:0,
            total:0,
            version:block.timestamp
            });

            Law.articles[articleId] = article;
        laws[id].push(Law);
    }

    function vote(uint256 id, uint256 version, int256 v) public payable {
        require(v >= -1, "Invalid vote");
        require(v <= 1, "Invalid vote");
        require(users(_personsContract).isActive(msg.sender), "NOT_A_CITIZEN");

        for(uint256 i = 0; i < votes[id].length; i++)
        {
            if (votes[id][i].addr == msg.sender)
            {
                laws[id][votes[id][i].version].votes -= votes[id][i].vote;
                laws[id][votes[id][i].version].total--;
                delete votes[id][i];
            }
        }
        cVote memory vot = cVote({
            addr : msg.sender,
            version : version,
            vote : v
        });
        votes[id].push(vot);
        laws[id][version].votes += v;
        laws[id][version].total++;
    }

    function getRevisions(uint256 id) public view returns(string memory revisions) {

        for (uint256 i = 0; i < laws[id].length; i++)
        {
            revisions = string.concat(Strings.toString(i),'#', laws[id][i].title,'#', laws[id][i].law,'#', Strings.toString(laws[id][i].version),'#', Strings.toString(int256(laws[id][i].votes)),'#', Strings.toString(laws[id][i].total),'|', revisions);
        }
    }

    function getRevision(uint256 id, uint256 version) public view returns(string memory revision) {
        revision = string.concat(Strings.toString(version),'#', laws[id][version].title,'#', laws[id][version].law);
        for(uint256 i = 0; i < laws[id][version].articles.length; i++)
        {
            revision = string.concat(revision,'#',laws[id][version].articles[i]);
        }
    }

    function getDocuments(uint256 id, uint256 version) public view returns(string memory documents) {

        for (uint256 i = 0; i < laws[id][version].documents.length; i++)
        {
            documents = string.concat(laws[id][version].documents[i],'#', documents);
        }
    }

    function getCurrentVersion(uint256 id) public view returns(uint256 version)
    {
        int256 max = 0;
        //uint256 maxDate = 0;
        for(uint256 i = 0; i < laws[id].length; i++)
        {
            (bool b, int256 v) = SafeMath.tryDiv((laws[id][i].votes*10000), int256(laws[id][i].total));
            if ((b) && (v >= max))
            {
                version = i;
            }
        }
    }

    function getLaw(uint256 id) public view returns (string memory law)
    {
        uint256 version = getCurrentVersion(id);

        law = getRevision(id, version);
    }

    function getLawCount() public view returns(uint256 count)
    {
        count = laws.length;
    }
    
    function getLaw(uint256 id, uint256 version) public view returns(cLaws memory L)
    {
        L = laws[id][version];
    }
    /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getOwner() external view returns (address) {
        return owner;
    }

} 


