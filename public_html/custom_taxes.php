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
		<link rel="stylesheet" href="style.css" crossorigin="anonymous">


</head>
        <body>
    <?php require('menu.php'); ?>

    <main id="main">
    <section id="clients" class="clients section-bg">
    <div class="container">
		<div class="card card-default">
			<div class="card-body">	
				<div class="card-title h4">Vote taxes 
				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#taxes-modal">
    				Propose
  				</button></div>
				<div class="card-text">
                    <hr>
					<table id="revisions" width="100%">
					<thead>
						<td>Rev.</td><td>Votes</td><td>Personal Tax</td><td>Company Tax</td><td>Value added</td><td>Health</td><td>Action</td>
					</thead>
					<tbody>
					</tbody>
				</table>
				</div>
			</div>
		</div>
</div>
</div>
</section>
</main>
<div id="taxes-modal" class="modal  fade" tabindex="-1">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="law-title">Modal title</h5>
        <button type="button" class="btn-close" onclick="$('#taxes-modal').modal('hide')" aria-label="Close"></button>
      </div>
      <div class="modal-body">
	  PIT (Personal Income Tax) : <br>
	  <input type="number" id="PIT"><br>
	  CIT (Company Income Tax) :<br>
	  <input type="number" id="CIT"><br>
	  VAT (Value Added Tax) :<br>
	  <input type="number" id="VAT"><br>
	  Healthcare :<br>
	  <input type="number" id="Health"><br>
	  </div>
      <div class="modal-footer">
	  <button type="button" class="btn btn-secondary" onclick="proposeTaxes($('#PIT').val(), $('#CIT').val(), $('#VAT').val(), $('#Health').val());displayTaxes();$('#taxes-modal').modal('hide')">Propose</button>
        <button type="button" class="btn btn-secondary" onclick="$('#taxes-modal').modal('hide')">Close</button>
      </div>
    </div>
  </div>
</div>
	</body>
	<script>
		var rev = $('#revisions').DataTable( {
			"filter": true,
            "searching": true,
			order: [[0, 'desc']]
} );
       async function displayTaxes() {
        rev.clear()
         var taxes = await getTaxesVotes();
         
        var cols = [[]]
		cols = cols.slice(1, 1)
	    lines = taxes.split('|');

	    for (var i = 0; i  < lines.length - 1; i++)
	    {
	  	    cols.push(lines[i].split('#'))
	    }

        taxes2 = cols;
        console.log(taxes2)
         for(var i = 0; i < taxes2.length;i++)
         {
            rev.row.add([i, '<span class="h5">'+taxes2[i][4]+'</span><span class="h4">/'+taxes2[i][5]+'</span>', taxes2[i][0]+'%', taxes2[i][1]+'%', taxes2[i][2]+'%', taxes2[i][3]+'%', 
            '<button class="btn btn-success b" onclick="voteTax(\''+i+'\', 1)">Yes</button>'+
            '<button class="btn btn-warning b" onclick="voteTax(\''+i+'\', 0)">Abtain</button>'+
            '<button class="btn btn-danger b" onclick="voteTax(\''+i+'\',-1)">No</button>'
        ]).draw();
         }
       }

       $('docment').ready(() =>{
        displayTaxes();
       })

	</script>
      <!-- Vendor JS Files -->


 
</html>
