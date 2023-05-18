var globId;
const ERC20TransferABI = [
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			}
		],
		"name": "LawCreated",
		"type": "event"
	},
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
				"name": "title",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "law",
				"type": "string"
			},
			{
				"internalType": "string[]",
				"name": "articles",
				"type": "string[]"
			},
			{
				"internalType": "string[]",
				"name": "documents",
				"type": "string[]"
			}
		],
		"name": "createLaw",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
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
				"internalType": "uint256",
				"name": "articleId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "version",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "article",
				"type": "string"
			}
		],
		"name": "proposeArticleEdit",
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
				"internalType": "string",
				"name": "law",
				"type": "string"
			},
			{
				"internalType": "string[]",
				"name": "articles",
				"type": "string[]"
			},
			{
				"internalType": "string[]",
				"name": "documents",
				"type": "string[]"
			}
		],
		"name": "proposeEdit",
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
				"internalType": "uint256",
				"name": "version",
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
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			}
		],
		"name": "getCurrentVersion",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "version",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
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
				"internalType": "uint256",
				"name": "version",
				"type": "uint256"
			}
		],
		"name": "getDocuments",
		"outputs": [
			{
				"internalType": "string",
				"name": "documents",
				"type": "string"
			}
		],
		"stateMutability": "view",
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
				"internalType": "uint256",
				"name": "version",
				"type": "uint256"
			}
		],
		"name": "getLaw",
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "title",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "law",
						"type": "string"
					},
					{
						"internalType": "string[]",
						"name": "articles",
						"type": "string[]"
					},
					{
						"internalType": "string[]",
						"name": "documents",
						"type": "string[]"
					},
					{
						"internalType": "int256",
						"name": "votes",
						"type": "int256"
					},
					{
						"internalType": "uint256",
						"name": "total",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "version",
						"type": "uint256"
					}
				],
				"internalType": "struct Laws.cLaws",
				"name": "L",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			}
		],
		"name": "getLaw",
		"outputs": [
			{
				"internalType": "string",
				"name": "law",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getLawCount",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "count",
				"type": "uint256"
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
		"inputs": [
			{
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "version",
				"type": "uint256"
			}
		],
		"name": "getRevision",
		"outputs": [
			{
				"internalType": "string",
				"name": "revision",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			}
		],
		"name": "getRevisions",
		"outputs": [
			{
				"internalType": "string",
				"name": "revisions",
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

const DAI_ADDRESS = "0xc1340DD87555962F490A71E5931C6b45A7d62c6A"


const web3 = new Web3("ws://localhost:8545")

const account =web3.eth.accounts.privateKeyToAccount("0x8284ee576fa47c45e396f285d77db57ed22a9c2307f8bd8e2f79eebd6fb088b5");

const daiToken = new web3.eth.Contract(ERC20TransferABI, DAI_ADDRESS)



async function getRevisions(id)
{
return await daiToken.methods.getRevisions(parseInt(id)).call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	return res
})}

async function getLawCount()
{
return await daiToken.methods.getLawCount().call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	return res
})}

async function getLaw(id)
{
return await daiToken.methods.getLaw(id).call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	return res
})}

async function getLastLaws()
{
	var laws = Array();
	var count = await getLawCount();

	if (count > 10) count = 10

	for (var i = count-1; i >= 0; i--)
	{
		laws.push(await getLaw(i))
	}
	return laws;
}

async function getDocuments(id, version)
{
return await daiToken.methods.getDocuments(parseInt(id), version).call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	files = res.split('#');
	for(var i = 0; i < files.length - 1; i++)
	{
		if (files[i].split('|')[1] !== undefined)
			$('#file-presentation').append('<tr id="a'+i+'"><td><a target="blank" href="ipfs-get.php?hash='+files[i]+'">'+files[i].split('|')[1]+'</a> <span onclick="files.splice('+i+', 1);$(\'#a'+i+'\').remove()">x</span></td></tr>');
	}
	return res
})}

async function getRevision(id, version)
{
return await daiToken.methods.getRevision(id, version).call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	var law = res.split('#');
	console.log(res);
	$('#file-presentation').html('');
	$('#law-title').text(law[1]);
	$('#law-edit').text(law[2].replace(/(?:\r\n|\r|\n)/g, '<br>'))

	$('#law-modal').modal('toggle');
	globId = id;
	$('#edit-articles').html('');
	var i2 = 1;
	for(var i=3; i < law.length; i++)
	{
		//aci
		$('#edit-articles').append('Article '+i2+'<div contenteditable  class=\'form-control editor\' id=\'b'+i+'\'>'+law[i].replace(/(?:\r\n|\r|\n)/g, '<br>')+'</div><button onclick="proposeArticleEdit('+id+', '+(i2-1)+', '+version+')">Update</button><hr>');
		i2++;
	}

	getDocuments(id, version);
})}

async function getRevisionVote(id, version)
{
return await daiToken.methods.getRevision(id, version).call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	var law = res.split('#');
	console.log(res);
	$('#law-title').text(law[1]);
	$('#law-edit').html(law[2].replace(/(?:\r\n|\r|\n)/g, '<br>'));
	$('#law-modal').modal('toggle');
	globId = id;
	$('#edit-articles').html('');
	var i2 = 1;
	for(var i=3; i < law.length; i++)
	{
		$('#edit-articles').append('<dt>Article '+i2+'</dt><li   >'+law[i].replace(/(?:\r\n|\r|\n)/g, '<br>')+'</li>');
		i2++;
	}
	$('#edit-articles').append('<div id="vote-buttons"></div>');
	$('#vote-buttons').append('<button class="btn btn-success b" onclick="vote(\''+id+'\',\''+version+'\',\'1\')">Yes</button>')
	$('#vote-buttons').append('<button class="btn btn-warning b" onclick="vote('+id+','+version+',0)">Abstain</button>')
	$('#vote-buttons').append('<button class="btn btn-danger b" onclick="vote('+id+','+version+',-1)">No</button>')
})}


async function processRevisions(id, vote=false, tab=null)	{
	var oldText = [];
	rev.clear().draw();
	var res = await getRevisions(id)
	var rows = res.split('|');
	    for (var i = 0; i < rows.length-1; i++) {
	    	var row = rows[i].split('#');
	    	const ts = new Date(row[3]*1000);
	    	const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
	    	row[2] = row[2].replace("\n", '<br>');

		row[2] = row[2].split('');
		const collection = collect(oldText);
	    	let diff = collection.union(row[2])
              //   .concat(row[2].filter(x => !oldText.includes(x))) 
	    	console.log(diff);
	    	
	    	text = ''; 
	    	for (var i2 = 0; i2 < diff.items.length; i2++)
	    	{
	    		if (diff.items[i2] != row[2][i2])
	    		{
		    		text += '<span style="color:red">'+row[2][i2]+'</span>';
	    	}
		    	else
		    	{
		    		if (typeof diff.items[i2] !== 'undefined')
		    		text += diff.items[i2];
		    	}
	    	}
	    	
	    	if (!vote)
	    		rev.row.add([row[0],'<span class="h5">'+row[4]+'</span><span class="h4">/'+row[5]+'</span>','<button onclick="getRevision('+id+', '+row[0]+')">Revise</button>',row[1],'<span class="td">'+text+'</span>',ts.toLocaleTimeString('ro-RO', options)]).draw();
	    	else
	    		rev.row.add([row[0],'<span class="h5">'+row[4]+'</span><span class="h4">/'+row[5]+'</span>','<button onclick="getRevisionVote('+id+', '+row[0]+')">Vote</button>',row[1],'<span class="td">'+text+'</span>',ts.toLocaleTimeString('ro-RO', options)]).draw();	    	
	    	oldText = diff.items;
	}
}

function createLaw(title, text)
{
	articles = []
	$('#articles').find('textarea').each((i, elem) => {
		articles.push(elem.value);
	})
	daiToken.methods
	.createLaw(title, text, articles, files)
	  .send({ from: account.address, gas:"3500000" }, function (err, res) {
	    if (err) {
	      console.log("An error occurred", err)
	      return
	    }
	    console.log("Hash of the transaction: " + res)
	   
	  })
}

function vote(id, version, vote)
{
var e2
try
{
	daiToken.methods
	.vote(id, version, vote)
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
	alert(e2)
}
}

function proposeEdit(id, text, articles)
{
	articles = []
	$('#edit-articles').find('div.editor').each((i, elem) => {
		articles.push(elem.innerText.replace(/(?:\r\n|\r|\n)/g, '<br>'));
	})
	daiToken.methods
	.proposeEdit(id, text, articles, files)
	  .send({ from: account.address, gas:"35000" }, function (err, res) {
	    if (err) {
	      console.log("An error occurred", err)
	      return
	    }
	    console.log("Hash of the transaction: " + res)
	  })
}

	    daiToken.events.LawCreated({}, function(err, data) {
  if (err)
    console.log("Error: " + err);
   else
   {
	if(alert("Law no. "+data.returnValues.id+" created !"))
	{
		window.location.href = './save.php?id='+data.returnValues.id;
	}
   }
});

function proposeArticleEdit(id, articleId, version)
{
	article = $('#b'+(articleId+3)).html();
	console.log(id+' '+articleId+' '+version);
	daiToken.methods
	.proposeArticleEdit(id, articleId, version, article)
	  .send({ from: account.address, gas:"3500000" }, function (err, res) {
	    if (err) {
	      console.log("An error occurred", err)
	      return
	    }
	    alert('Law '+id+' article '+articleId+' proposed !')
	  })
}

	    daiToken.events.LawCreated({}, function(err, data) {
  if (err)
    console.log("Error: " + err);
   else
   {
	if(alert("Law no. "+data.returnValues.id+" created !"))
	{
		window.location.href = './save.php?id='+data.returnValues.id;
	}
   }
});



