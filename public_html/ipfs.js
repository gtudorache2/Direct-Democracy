var IPFSHash
const ipfs = new window.IpfsHttpClient({ host: 'ipfs.infura.io', port: 5001 })
function ipfsUpload(file)
{

	  
	  var reader = new FileReader();
	  reader.onload = function() {

	    var arrayBuffer = this.result,
	      array = new Uint8Array(arrayBuffer),
	      binaryString = String.fromCharCode.apply(null, array);

	    //console.log(result)
	    ipfs.add(binaryString, (err, result) => {
	      console.log(result)
	      $('#other-data').val(result[0].hash)
	    })
	  }
	  reader.readAsArrayBuffer(file);

}
