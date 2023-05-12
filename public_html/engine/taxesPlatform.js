
const taxesABI = [
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "oldOwner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "OwnerSet",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "changeOwner",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "companyID",
				"type": "string"
			},
			{
				"internalType": "int8",
				"name": "tax",
				"type": "int8"
			}
		],
		"name": "proposeCustomTaxes",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "int8",
				"name": "PIT",
				"type": "int8"
			},
			{
				"internalType": "int8",
				"name": "CIT",
				"type": "int8"
			},
			{
				"internalType": "int8",
				"name": "VAT",
				"type": "int8"
			},
			{
				"internalType": "int8",
				"name": "Health",
				"type": "int8"
			}
		],
		"name": "proposeStandardTaxes",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			},
			{
				"internalType": "int256",
				"name": "v",
				"type": "int256"
			}
		],
		"name": "vote",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			},
			{
				"internalType": "int256",
				"name": "v",
				"type": "int256"
			}
		],
		"name": "voteCustom",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [],
		"name": "getCurrentTaxes",
		"outputs": [
			{
				"components": [
					{
						"internalType": "int8",
						"name": "PIT",
						"type": "int8"
					},
					{
						"internalType": "int8",
						"name": "CIT",
						"type": "int8"
					},
					{
						"internalType": "int8",
						"name": "VAT",
						"type": "int8"
					},
					{
						"internalType": "int8",
						"name": "Health",
						"type": "int8"
					},
					{
						"internalType": "int256",
						"name": "votes",
						"type": "int256"
					},
					{
						"internalType": "int256",
						"name": "total",
						"type": "int256"
					}
				],
				"internalType": "struct Taxes.cStandardTaxesProp",
				"name": "taxes",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getCustomTaxes",
		"outputs": [
			{
				"internalType": "string",
				"name": "taxes",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getOwner",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getVotes",
		"outputs": [
			{
				"internalType": "string",
				"name": "v",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]
function calcHeight(value) {
  let numberOfLineBreaks = (value.match(/\n/g) || []).length;
  // min-height + lines x line-height + padding + border
  let newHeight = numberOfLineBreaks + 2;
  return newHeight;
}

const ADDRESS = "0x8f6888A4f8AAb9903364eD93BE9e9A126F4160C6"



const taxes = new web3.eth.Contract(taxesABI, ADDRESS)



async function getTaxes()
{
return await taxes.methods.getCurrentTaxes().call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	  console.log(res)
	return res
})}

async function getCustomTaxes()
{
return await taxes.methods.getCustomTaxes().call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	  console.log(res)
	return res
})}

function voteTax(id, vote)
{
var e2
try
{
	taxes.methods
	.vote(id, vote)
	  .send({ from: account.address, gas:"3500000" }, function (err, res) {
	    if (err) {
	      alert(err)
	      return
	    }
	    alert('Success !')
	    displayTaxes()
	    console.log("Hash of the transaction: " + res)
	  })
}
catch (e)
{
	alert(e2)
}}

async function getTaxesVotes()
{
return await taxes.methods.getVotes().call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	return res
})}

function proposeTaxes(PIT, CIT, VAT, Health)
{
var e2
try
{
	taxes.methods
	.proposeStandardTaxes(PIT, CIT, VAT, Health)
	  .send({ from: account.address, gas:"3500000" }, function (err, res) {
	    if (err) {
	      alert(err)
	      return
	    }
	    alert('Success !')
	    displayTaxes()
	    console.log("Hash of the transaction: " + res)
	  })
}
catch (e)
{
	alert(e)
}}

function proposeCustomTax(id, tax)
{
	var e2
	try
	{
		taxes.methods
		.proposeCustomTaxes(id, tax)
		.send({ from: account.address, gas:"3500000" }, function (err, res) {
			if (err) {
			alert(err)
			return
			}
			alert('Success !')
			console.log("Hash of the transaction: " + res)
		})
	}
	catch (e)
	{
		alert(e)
	}
}
