// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "taxes.sol";

contract Currency {
    Taxes tax;
    string public constant name = "kWCoin";
    string public constant symbol = "KWC";
    uint8 public constant decimals = 18;  

    address state; 
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);

    mapping(address => uint256) balances;

    mapping(address => mapping (address => uint256)) allowed;
    
    uint256 totalSupply_;

    using SafeMath for uint256;
    

   constructor() public {  
        state = msg.sender;
	    totalSupply_ = address(state).balance;
	    balances[state] = totalSupply_;
    }  

    function addToState(uint256 amount) private {
        totalSupply_ = totalSupply_.add(amount);
	    balances[state] += totalSupply_;
    }

    function substractFromState(uint256 amount) private {
        totalSupply_ = totalSupply_.sub(amount);
	    balances[state] += totalSupply_;
    }

    function connectToTax(address taxContract) public payable {
        tax = Taxes(taxContract);
    }

    function totalSupply() public view returns (uint256) {
	return totalSupply_;
    }
    
    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint numTokens) public returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function buy(address receiver, uint numTokens, string memory companyID, string memory product) public returns (bool) {
        require(numTokens <= balances[msg.sender]);

        int256 calcTax = int256(numTokens)*1000 * tax.getTax(companyID) / 100;

        int256 calcVAT = int256(numTokens)*1000 * tax.getCurrentTaxes().VAT /100;

        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);     
        
        if (calcTax < 0)
        {
            calcTax = -calcTax;
            substractFromState(uint256(calcTax));
            balances[receiver] = balances[receiver].add(uint256(calcTax));
        }
        else
        {
            addToState(uint256(calcTax));
            balances[receiver] = balances[receiver].sub(uint256(calcTax));
        }
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint numTokens) public returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint numTokens) public returns (bool) {
        require(numTokens <= balances[owner]);    
        require(numTokens <= allowed[owner][msg.sender]);
    
        balances[owner] = balances[owner].sub(numTokens);
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}
