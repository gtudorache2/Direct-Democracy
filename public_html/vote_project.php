<!DOCTYPE html>
<html>

	<head>
    <meta charset="utf-8">

  <meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Arsha Bootstrap Template - Index</title>
<meta content="" name="description">
<meta content="" name="keywords">
		<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
        <link rel="stylesheet" href="style1.css" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
		<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/web3@1.2.11/dist/web3.min.js"></script>
		<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
		<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/collect.js/4.18.3/collect.min.js" integrity="sha512-LkKpealLJ+RNIuYaXSC+l/0Zf5KjYCpMaUrON9WUC+LG316w3UEImyaUpWMWfqNGC4vLOkxDWEVKQE+Wp0shKg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>	</head>
        <script src="https://cdn.jsdelivr.net/npm/ipfs/dist/index.min.js"></script>
</head>
        <body>
    <?php require('menu.php'); ?>

    <main id="main">
    <section id="clients" class="clients section-bg">
    <div class="container">
		<div class="card card-default">
			<div class="card-body">	
				<div class="card-title h4">Vote</div>
				<div class="card-text">
                <div class="input-group mb-3">
					<input placeholder="Project number" value="<?=$_GET['id']?>" class="form-control" id="id" aria-describedby="get" /><button id="get" class="btn btn-warning" onclick="processProjectRevisions($('#id').val(), true);">Get revisions</button>
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
</div>
<div id="project-modal" class="modal  fade" tabindex="-1">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="project-title">Modal title</h5>
        <button type="button" class="btn-close" onclick="$('#project-modal').modal('hide')" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="project-edit" style="Width:100%"></div>
        <hr>

		<dl id="edit-articles" style="margin-left:25px;border:1px solid lightgrey">

</dl>
			<hr>				
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" onclick="$('#project-modal').modal('hide')">Close</button>
      </div>
    </div>
  </div>
</div>
</section>
</main>
	</body>
	<script>
		var rev = $('#revisions').DataTable( {
			"filter": true,
            "searching": true,
			order: [[0, 'desc']]
} );
        <?php
        if (is_numeric($_GET['id']))
        {
            echo "processProjectRevisions(".$_GET['id'].", true);";
        }
        ?>
	</script>
      <!-- Vendor JS Files -->


 
</html>
