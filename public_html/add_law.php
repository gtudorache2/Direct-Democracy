<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script>		var files = Array(); </script>
		<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
		<link rel="stylesheet" href="style.css" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
		<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
		<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js" integrity="sha256-lSjKY0/srUM9BE3dPm+c4fBo1dky2v27Gdjm2uoZaL0=" crossorigin="anonymous"></script>		<script src="node_modules/blueimp-file-upload/js/jquery.fileupload.js"></script>	

		<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
		<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>


		<script src="https://cdnjs.cloudflare.com/ajax/libs/collect.js/4.18.3/collect.min.js" integrity="sha512-LkKpealLJ+RNIuYaXSC+l/0Zf5KjYCpMaUrON9WUC+LG316w3UEImyaUpWMWfqNGC4vLOkxDWEVKQE+Wp0shKg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>	</head>
	<body>
	<?php require('menu.php'); ?>
	<main id="main">
    <section id="clients" class="clients section-bg">
	<div class="container">
		<div class="card card-default">
			<div class="card-body">
			<div class="panel-title h4">Create Law</div>
			<div class="card-text">
				Title : <input class="form-control" id="title" /><br>
				Law : <textarea class="form-control" id="law" rows="5"></textarea></br>		
				<div class="card card-default">
					<div class="card-body">
					<div class="panel-title h5">Articles</div>
					<div class="card-text" id="articles" >
						<textarea class="form-control" rows="5"></textarea>
					</div>
				</div>
				<hr>
				<form
        id="fileupload"
        action="ipfs.php"
        method="POST"
        enctype="multipart/form-data"
      >
        <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
        <div class="row fileupload-buttonbar">
          <div class="col-lg-7">
            <!-- The fileinput-button span is used to style the file input field as button -->
            <span class="btn btn-success fileinput-button">
              <i class="glyphicon glyphicon-plus"></i>
              <span>Add files...</span>
              <input type="file" id="file-button" name="files" />
            </span>
            <span class="btn btn-warning fileinput-button" onclick="$('#articles').append('<textarea class=\'form-control\' rows=\'5\'></textarea>'); return false">Add article</button>
			</span>	
            <!-- The global file processing state -->
            <span class="fileupload-process"></span>
          </div>
          <!-- The global progress state -->
          <div class="col-lg-5 fileupload-progress fade">
            <!-- The global progress bar -->
            <div
              class="progress progress-striped active"
              role="progressbar"
              aria-valuemin="0"
              aria-valuemax="100"
            >
              <div
                class="progress-bar progress-bar-success"
                style="width: 0%;"
              ></div>
            </div>
            <!-- The extended global progress state -->
            <div class="progress-extended">&nbsp;</div>
          </div>
        </div>
        <!-- The table listing the files available for upload/download -->
        <table role="presentation" id="file-presentation" class="table table-striped">
          <tbody class="files"></tbody>
        </table>
      </form>


				<button class="btn btn-warning" onclick="createLaw($('#title').val(), $('#law').val())">Create Law</button><br>
			</div>
			</div>		
		</div>
	</div>
</section>
</main>
	</body>
	<script src="node_modules/blueimp-file-upload/js/jquery.fileupload.js"></script>
	<script src="node_modules/blueimp-file-upload/js/jquery.fileupload-ui.js"></script>
	<link rel="stylesheet" href="node_modules/blueimp-file-upload/css/jquery.fileupload.css" />
    <link rel="stylesheet" href="node_modules/blueimp-file-upload/css/jquery.fileupload-ui.css" />
	<script defer>

$( document ).ready(function() {
		var rev = $('#revisions').DataTable( {
			"filter": true,
            "searching": true,
			order: [[0, 'desc']]
} );
async function sub(data)
{
	try
		{
	var resp = await data.submit()
	files.push(resp.responseText)
	var idx = files.length - 1;
	$('#file-presentation').append('<tr id="a'+idx+'"><td>'+resp.responseText.split('|')[1]+' <span onclick="files.splice('+idx+', 1);$(\'#a'+idx+'\').delete()">x</span></td></tr>');
}
		catch (e)
		{
			console.log(e)
			files.push(e.responseText)
			var idx = files.length - 1;
			$('#file-presentation').append('<tr id="a'+idx+'"><td><a target="blank" href="ipfs-get.php?hash='+e.responseText+'">'+e.responseText.split('|')[1]+'</a> <span onclick="files.splice('+idx+', 1);$(\'#a'+idx+'\').remove()">x</span></td></tr>');
		}


}
var fu = $('#fileupload').fileupload({
	autoUpload:true,
	add: (e, data) => {
		sub(data)
		}
	})

})
	</script>

<?php require_once('footer.php.php'); ?>
</html>
