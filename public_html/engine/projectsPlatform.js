var globId;
const projectsABI = [
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
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			}
		],
		"name": "ProjectCreated",
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
				"name": "project",
				"type": "string"
			},
			{
				"internalType": "string[]",
				"name": "attachments",
				"type": "string[]"
			},
			{
				"internalType": "int256",
				"name": "value",
				"type": "int256"
			}
		],
		"name": "createProject",
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
				"internalType": "string",
				"name": "project",
				"type": "string"
			},
			{
				"internalType": "string[]",
				"name": "enhanchments",
				"type": "string[]"
			},
			{
				"internalType": "uint256[]",
				"name": "values",
				"type": "uint256[]"
			},
			{
				"internalType": "string[]",
				"name": "attachments",
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
				"name": "eId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "version",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "enhanchment",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "proposeEnhanchmentEdit",
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
			},
			{
				"internalType": "uint256",
				"name": "version",
				"type": "uint256"
			}
		],
		"name": "getAttachments",
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
			}
		],
		"name": "getProject",
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
		"name": "getProjectCount",
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
		"name": "getSpecificProject",
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
						"name": "project",
						"type": "string"
					},
					{
						"internalType": "string[]",
						"name": "enhanchments",
						"type": "string[]"
					},
					{
						"internalType": "uint256[]",
						"name": "values",
						"type": "uint256[]"
					},
					{
						"internalType": "string[]",
						"name": "attachments",
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
					},
					{
						"internalType": "int256",
						"name": "value",
						"type": "int256"
					}
				],
				"internalType": "struct Projects.cProjects",
				"name": "L",
				"type": "tuple"
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

const PROJECTS_CONTRACT_ADDRESS = "0xaA090558E20520365140250c2065A35912f803b9";


const projects = new web3.eth.Contract(projectsABI, PROJECTS_CONTRACT_ADDRESS)



async function getProjectRevisions(id)
{
return await projects.methods.getRevisions(parseInt(id)).call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	return res
})}

async function getProjectCount()
{
return await projects.methods.getProjectCount().call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	return res
})}

async function getProject(id)
{
return await projects.methods.getProject(id).call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	return res
})}

async function getLastProjects()
{
	var projects = Array();
	var count = await getProjectsCount();

	if (count > 10) count = 10

	for (var i = count-1; i >= 0; i--)
	{
		projects.push(await getProject(i))
	}
	return projects;
}

async function getAttachments(id, version)
{
return await projects.methods.getAttachments(parseInt(id), version).call(function (err, res) {
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

async function getProjectRevision(id, version)
{
	tiny = Array();
return await projects.methods.getRevision(id, version).call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	var project = res.split('#');
	console.log(project);
	$('#file-presentation').html('');
	$('#project-title').text(project[1]);
	$('#project-edit').html(project[2]);
	$('#value').text('Value : '+project[3])
	$('#project-modal').modal('toggle');
	globId = id;
	$('#edit-articles').html('');
	var i2 = 1;

	tinymce.init({
        selector: '#project-edit',
        plugins: 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount',
        toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bullist indent outdent | emoticons charmap | removeformat',
      })

	for(var i=4; i < project.length; i+=2)
	{
		//aci
		addTiny(project[i], i2, project[i+1]);
//		$('#edit-articles').append('<input type="number" value="'+project[i+1]+'" id="v'+i+'"><button onclick="proposeArticleEdit('+id+', '+(i2-1)+', '+version+')">Update</button><hr>');
		i2++;
	}

	getAttachments(id, version);
})}

async function getProjectRevisionVote(id, version)
{
return await projects.methods.getRevision(id, version).call(function (err, res) {
	  if (err) {
	    console.log("An error occurred", err)
	    return
	  }
	var project = res.split('#');
	console.log(res);
	$('#project-title').text(project[1]);
	$('#project-edit').html(project[2].replace(/(?:\r\n|\r|\n)/g, '<br>')+'<br>Value : '+project[3]);
	$('#project-modal').modal('toggle');
	globId = id;
	$('#edit-articles').html('');
	var i2 = 1;
	for(var i=4; i < project.length; i+=2)
	{
		$('#edit-articles').append('<dt>Enhanchment '+i2+'</dt><li   >'+project[i].replace(/(?:\r\n|\r|\n)/g, '<br>')+'<br> Value : '+project[i+1]+'</li>');
		i2++;
	}
	$('#edit-articles').append('<div id="vote-buttons"></div>');
	$('#vote-buttons').append('<button class="btn btn-success b" onclick="voteProject(\''+id+'\',\''+version+'\',\'1\')">Yes</button>')
	$('#vote-buttons').append('<button class="btn btn-warning b" onclick="voteProject('+id+','+version+',0)">Abstain</button>')
	$('#vote-buttons').append('<button class="btn btn-danger b" onclick="voteProject('+id+','+version+',-1)">No</button>')
})}


async function processProjectRevisions(id, vote=false, tab=null)	{
	var oldText = [];
	rev.clear().draw();
	var res = await getProjectRevisions(id)
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
	    		rev.row.add([row[0],'<span class="h5">'+row[4]+'</span><span class="h4">/'+row[5]+'</span>','<button onclick="getProjectRevision('+id+', '+row[0]+')">Revise</button>',row[1],'<span class="td">'+text+'</span>',ts.toLocaleTimeString('ro-RO', options)]).draw();
	    	else
	    		rev.row.add([row[0],'<span class="h5">'+row[4]+'</span><span class="h4">/'+row[5]+'</span>','<button onclick="getProjectRevisionVote('+id+', '+row[0]+')">Vote</button>',row[1],'<span class="td">'+text+'</span>',ts.toLocaleTimeString('ro-RO', options)]).draw();	    	
	    	oldText = diff.items;
	}
}

function createProject(title, text, value)
{
	articles = []
	$('#articles').find('textarea').each((i, elem) => {
		articles.push(elem.value);
	})
	projects.methods
	.createProject(title, text, files, value)
	  .send({ from: account.address, gas:"3500000" }, function (err, res) {
	    if (err) {
	      console.log("An error occurred", err)
	      return
	    }
	    console.log("Hash of the transaction: " + res)
	   
	  })
}

function voteProject(id, version, vote)
{
var e2
try
{
	projects.methods
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

function proposeProjectEdit(id, text, value)
{
	articles = []
    values = []
	for (var i = 0; i < tiny.length;i++)
	{
		articles.push(tinymce.get("b"+(i+1)).getContent());
	}
	$('#edit-articles').find('input[type=number]').each((i, elem) => {
		values.push(elem.value);
	})
    console.log(values);
	projects.methods
	.proposeEdit(id, text, articles, values, files)
	  .send({ from: account.address, gas:"350000" }, function (err, res) {
	    if (err) {
	      console.log("An error occurred", err)
	      return
	    }
	    console.log("Hash of the transaction: " + res)
	  })
}

	    projects.events.ProjectCreated({}, function(err, data) {
  if (err)
    console.log("Error: " + err);
   else
   {
	if(alert("Project no. "+data.returnValues.id+" created !"))
	{
		window.location.href = './save.php?id='+data.returnValues.id;
	}
   }
});

function proposeEnhanchmentEdit(id, articleId, version, value)
{
	article = $('#b'+(articleId+3)).html();
	console.log(id+' '+articleId+' '+version);
	projects.methods
	.proposeEnhanchmentEdit(id, articleId, version, article, value)
	  .send({ from: account.address, gas:"3500000" }, function (err, res) {
	    if (err) {
	      console.log("An error occurred", err)
	      return
	    }
	    alert('Project '+id+' article '+articleId+' proposed !')
	  })
}

	    projects.events.ProjectCreated({}, function(err, data) {
  if (err)
    console.log("Error: " + err);
   else
   {
	if(alert("Project no. "+data.returnValues.id+" created !"))
	{
		window.location.href = './save.php?id='+data.returnValues.id;
	}
   }
});



