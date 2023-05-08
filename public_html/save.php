<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script>		var files = Array(); var rev;</script>
		<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
		<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
		<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js" integrity="sha256-lSjKY0/srUM9BE3dPm+c4fBo1dky2v27Gdjm2uoZaL0=" crossorigin="anonymous"></script>		<script src="node_modules/blueimp-file-upload/js/jquery.fileupload.js"></script>	
        <script src="https://cdn.jsdelivr.net/npm/web3@1.2.11/dist/web3.min.js"></script>
		<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
		<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
		<script src="platform.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/collect.js/4.18.3/collect.min.js" integrity="sha512-LkKpealLJ+RNIuYaXSC+l/0Zf5KjYCpMaUrON9WUC+LG316w3UEImyaUpWMWfqNGC4vLOkxDWEVKQE+Wp0shKg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>	</head>
		<link rel="stylesheet" href="style.css" crossorigin="anonymous">
    </head>
        <body>
	<?php require('menu.php'); ?>
    <main id="main">
    <section id="clients" class="clients section-bg">
	<div class="container">
		<hr>
		<div class="card card-default">
			<div class="card-body">	
				<div class="card-title h4">Get revisions</div>
				<div class="card-text">
                    <div class="input-group mb-3">
					    <input placeholder="Law number" value="<?=$_GET['id']?>" class="form-control" id="id" /><button class="btn btn-warning" onclick="processRevisions($('#id').val());">Get revisions</button>
                    </div>
                    <hr>
					<table id="revisions" width="100%">
					<thead>
						<td>Rev.</td><td>Votes</td><td>Action</td><td>Title</td><td>Contents</td><td>Date</td>
					</thead>
					<tbody>
					</tbody>
				</table>
				</div>
			</div>
		</div>
<div id="law-modal" class="modal fade" tabindex="-1">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="law-title">Modal title</h5>
        <button type="button" class="btn-close" onclick="$('#law-modal')..modal('hide')" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div contenteditable id="law-edit" rows="20" style="Width:100%"></div>
        <hr>
		<div id="edit-articles" style="margin-left:25px;border:1px solid lightgrey">
				<textarea class="form-control" rows="5"></textarea>
			</div>
			<hr>				
			<button class="btn btn-warning" onclick="$('#edit-articles').append('<div contenteditable class=\'form-control editor\'><br></div>')">Add article</button>

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

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" onclick="$('#law-modal').modal('hide')">Close</button>
        <button type="button" class="btn btn-primary" onclick="proposeEdit(globId, $('#law-edit').text());$('#law-modal').modal('hide')">Save changes</button>
      </div>
    </div>
  </div>
</div>
</section>
</main>
	</body>
    <?php require_once('footer.php.php') ?>
	<script defer>
		rev = $('#revisions').DataTable( {
			"filter": true,
            "searching": true,
			order: [[0, 'desc']],
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
$( document ).ready(function() {

<?php if (is_numeric($_GET['id']))
                {
                    echo "processRevisions(".$_GET['id'].", false, $('#revisions'));";
                }
            ?>

        })
var fu = $('#fileupload').fileupload({
	autoUpload:true,
	add: (e, data) => {
		sub(data)
		}
	})

	</script>
    	<script src="node_modules/blueimp-file-upload/js/jquery.fileupload.js"></script>
	<script src="node_modules/blueimp-file-upload/js/jquery.fileupload-ui.js"></script>
	<link rel="stylesheet" href="node_modules/blueimp-file-upload/css/jquery.fileupload.css" />
    <link rel="stylesheet" href="node_modules/blueimp-file-upload/css/jquery.fileupload-ui.css" />

</html>
