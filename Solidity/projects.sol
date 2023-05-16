// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "hardhat/console.sol";
import "OpenZeppelin.mod/Strings.sol";
import "OpenZeppelin.mod/math/SafeMath.sol";
/**
 * @title Owner
 * @dev Set & change owner
 */
contract Projects {

    address private owner;

    struct cProjects {
        string title;
        string project;
        string[] enhanchments;
        uint256[] values;
        string[] attachments;
        int256 votes;
        uint256 total;
        uint256 version;
        int256 value;
    }

    struct cVote {
        address addr;
        uint256 version;
        int256 vote;
    }

    struct cEnhanchments {
        string enhanchment;
        int256 value;
    }

    cEnhanchments empty = cEnhanchments({
          enhanchment:"",
          value:0
     });
    string[] emptyArr;
    uint256[] emptyArr2;
    cVote[][] votes;
    cProjects[][] projects;

    uint256 projectIndex = 0;
    // event for EVM logging
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    event ProjectCreated(uint256 indexed id);
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
    }

    /**
     * @dev Change owner
     * @param newOwner address of new owner
     */
    function changeOwner(address newOwner) public isOwner {
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }


    function createProject(string memory title, string memory project, string[] memory attachments, int256 value) public payable returns (uint256) {
        
        require(bytes(project).length > 10, "Text to small");
        require(bytes(title).length > 4, "Text too small");

        cProjects memory Project = cProjects({
            title:title,
            project:project,
            enhanchments:emptyArr,
            values:emptyArr2,
            attachments:attachments,
            votes:0,
            total:0,
            value:value,
            version:block.timestamp
            });
        projects.push();
        projects[projects.length-1].push(Project);
        projectIndex++;
        votes.push();
        emit ProjectCreated(projects.length-1);
        return projects.length-1;
    }

    function proposeEdit(uint256 id, string memory project, string[] memory enhanchments, uint256[] memory values, string[] memory attachments) public payable {
         cProjects memory Project = cProjects({
            title:projects[id][0].title,
            project:project,
            enhanchments:enhanchments,
            values:values,
            attachments:attachments,
            votes:0,
            total:0,
            value:projects[id][0].value,
            version:block.timestamp
            });
        projects[id].push(Project);
    }

    function proposeEnhanchmentEdit(uint256 id, uint256 eId, uint256 version, string memory enhanchment, uint256 value) public payable {
         
         cProjects memory Project = cProjects({
            title:projects[id][version].title,
            project: projects[id][version].project,
            enhanchments:projects[id][version].enhanchments,
            values:projects[id][version].values,
            attachments:projects[id][version].attachments,
            votes:0,
            total:0,
            value:projects[id][version].value,
            version:block.timestamp
            });

            Project.enhanchments[eId] = enhanchment;
            Project.values[eId] = value;
            projects[id].push(Project);
    }

    function vote(uint256 id, uint256 version, int256 v) public payable {
        require(v >= -1, "Invalid vote");
        require(v <= 1, "Invalid vote");


        for(uint256 i = 0; i < votes[id].length; i++)
        {
            if (votes[id][i].addr == msg.sender)
            {
                projects[id][votes[id][i].version].votes -= votes[id][i].vote;
                projects[id][votes[id][i].version].total--;
                delete votes[id][i];
            }
        }
        cVote memory vot = cVote({
            addr : msg.sender,
            version : version,
            vote : v
        });
        votes[id].push(vot);
        projects[id][version].votes += v;
        projects[id][version].total++;
    }

    function getRevisions(uint256 id) public view returns(string memory revisions) {

        for (uint256 i = 0; i < projects[id].length; i++)
        {
            revisions = string.concat(Strings.toString(i),'#', projects[id][i].title,'#', projects[id][i].project,'#', Strings.toString(projects[id][i].version),'#', Strings.toString(int256(projects[id][i].votes)),'#', Strings.toString(projects[id][i].total),'|', revisions);
        }
    }

    function getRevision(uint256 id, uint256 version) public view returns(string memory revision) {
        revision = string.concat(Strings.toString(version),'#', projects[id][version].title,'#', projects[id][version].project,'#', Strings.toString(projects[id][version].value));
        for(uint256 i = 0; i < projects[id][version].enhanchments.length; i++)
        {
            revision = string.concat(revision,'#',projects[id][version].enhanchments[i],'#',Strings.toString(projects[id][version].values[i]));
        }
    }

    function getAttachments(uint256 id, uint256 version) public view returns(string memory documents) {

        for (uint256 i = 0; i < projects[id][version].attachments.length; i++)
        {
            documents = string.concat(projects[id][version].attachments[i],'#', documents);
        }
    }

    function getCurrentVersion(uint256 id) public view returns(uint256 version)
    {
        int256 max = 0;
        //uint256 maxDate = 0;
        for(uint256 i = 0; i < projects[id].length; i++)
        {
            (bool b, int256 v) = SafeMath.tryDiv((projects[id][i].votes*10000), int256(projects[id][i].total));
            if ((b) && (v >= max))
            {
                version = i;
            }
        }
    }

    function getProject(uint256 id) public view returns (string memory law)
    {
        uint256 version = getCurrentVersion(id);

        law = getRevision(id, version);
    }

    function getProjectCount() public view returns(uint256 count)
    {
        count = projects.length;
    }
    
    function getSpecificProject(uint256 id, uint256 version) public view returns(cProjects memory L)
    {
        L = projects[id][version];
    }
    /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getOwner() external view returns (address) {
        return owner;
    }

} 


