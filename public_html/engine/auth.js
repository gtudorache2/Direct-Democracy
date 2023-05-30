
const authABI = [
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "UID",
				"type": "address"
			}
		],
		"name": "accountCreated",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "bytes32",
				"name": "session",
				"type": "bytes32"
			}
		],
		"name": "loggedIn",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "UID",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "pass",
				"type": "string"
			}
		],
		"name": "authenthicate",
		"outputs": [
			{
				"internalType": "bytes32",
				"name": "",
				"type": "bytes32"
			}
		],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "fullName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "SSN",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "homeAddress",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "pass",
				"type": "string"
			},
			{
				"internalType": "uint8",
				"name": "accountType",
				"type": "uint8"
			},
			{
				"internalType": "string",
				"name": "phone",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "addr",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "companyCode",
				"type": "string"
			}
		],
		"name": "createAccount",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "UID",
				"type": "address"
			}
		],
		"name": "deleteUser",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "fullName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "homeAddress",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "phone",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "blockAccount",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "companyCode",
				"type": "string"
			},
			{
				"internalType": "bytes32",
				"name": "session",
				"type": "bytes32"
			}
		],
		"name": "editUser",
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
		"inputs": [
			{
				"internalType": "bytes32",
				"name": "session",
				"type": "bytes32"
			}
		],
		"name": "checkLogin",
		"outputs": [],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getPopulation",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "UID",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "pass",
				"type": "string"
			}
		],
		"name": "getUser",
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "fullName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "SSN",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "homeAddress",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "pass",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "phone",
						"type": "string"
					},
					{
						"internalType": "uint8",
						"name": "accountType",
						"type": "uint8"
					},
					{
						"internalType": "string",
						"name": "companyCode",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "blockAccount",
						"type": "address"
					},
					{
						"internalType": "bytes32",
						"name": "UID",
						"type": "bytes32"
					},
					{
						"internalType": "bytes32",
						"name": "session",
						"type": "bytes32"
					}
				],
				"internalType": "struct Auth.person",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]

const AUTH_ADDRESS = "0x5337A7482c89f53e97a306Ea78fE64DA4cF2D6ed"



const auth = new web3.eth.Contract(authABI, AUTH_ADDRESS)



function authenthicate(user, pass)
{
pass = web3.utils.soliditySha3({ type: 'string', value:pass});
console.log(pass);
	auth.methods
	.authenthicate(account.address, pass)
	  .send({ from: account.address, gas:"3500000" }, function (err, res) {
	    if (err) {
	      alert(err)
	      return
	    }
	    console.log("Hash of the transaction: " + res)
	  })
}

auth.events.loggedIn({}, function(err, data) {
    if (err)
      console.log("Error: " + err);
     else
     {
      console.log(data.returnValues);
      alert("Succesfully logged in !")
      {
          document.cookie = 'ses='+data.returnValues.session;
          window.location.href = './index.php';
      }
     }
  });