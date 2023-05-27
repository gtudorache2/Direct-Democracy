<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
		<link rel="stylesheet" href="style.css" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
		<script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
		<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js" integrity="sha256-lSjKY0/srUM9BE3dPm+c4fBo1dky2v27Gdjm2uoZaL0=" crossorigin="anonymous"></script>		<script src="node_modules/blueimp-file-upload/js/jquery.fileupload.js"></script>	
		<script src="https://cdn.jsdelivr.net/npm/web3@1.2.11/dist/web3.min.js"></script>
		<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
		<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-csv/1.0.21/jquery.csv.min.js" integrity="sha512-Y8iWYJDo6HiTo5xtml1g4QqHtl/PO1w+dmUpQfQSOTqKNsMhExfyPN2ncNAe9JuJUSKzwK/b6oaNPop4MXzkwg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>	<body>
</head>
<body>
        <?php require('menu.php'); ?>
        <main id="main">
    <section id="clients" class="clients section-bg">
	<div class="container">
        <div class="card card-default">
                <div class="card-body">
                    <div class="panel-title h4">Company types</div>
                    <div class="card-text">
                        <table id="types">
                            <thead>

                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
        </div>
</div>
<div id="taxes-modal" class="modal  fade" tabindex="-1">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="law-title">Propose tax</h5>
        <button type="button" class="btn-close" onclick="$('#taxes-modal').modal('hide')" aria-label="Close"></button>
      </div>
      <div class="modal-body">
	  Value in percents : <br>
	  <input type="number" id="tax"><br>
      <input type="hidden" id="tax-id" />
	  </div>
      <div class="modal-footer">
	  <button type="button" class="btn btn-secondary" onclick="proposeProductTax($('#tax-id').val(), $('#tax').val());$('#taxes-modal').modal('hide')">Propose</button>
        <button type="button" class="btn btn-secondary" onclick="$('#taxes-modal').modal('hide')">Close</button>
      </div>
    </div>
  </div>
</div>
</main>
</section>
</body>
<?php require('footer.php.php'); ?>
<script>
    function addTax(id)
    {
        $('#tax-id').val(id);
        $('#taxes-modal').modal('toggle');
    }
$(document).ready(function() {

    var table 

                $.ajax({
                url: "product_codes.csv",
                async: false,
                success: async function (csvd) {
                    var taxes = await getProductTaxes();
                    taxes = taxes.split('|');
                    var items = $.csv.toObjects(csvd);
                    for(var i = 0; i < items.length; i++)
                    {
                        var tax = 0;

                        for(var i2 = 0; i2 < taxes.length; i2++)
                        {
                            var col = taxes[i2].split('#');
                            if(items[i].CODE == col[1])
                            {
                                tax = col[2];
                                break;
                            }
                        }
                        Object.assign(items[i], {"Action" : "<button class='btn btn-warning' onclick='addTax(\""+items[i].CODE+"\")'>Propose Tax</button>", "Tax":tax+'%'});
                    }
                    
                    console.log(items);
                var obj = {data: items}
            //    jsonobject = JSON.stringify(obj);

                    table = $('#types').DataTable({ 
                        data:items,
                        columns:[
                            {sercheable:false,title:"Action", data:"Action"},
                            {sercheable:true, title:"Code", data:"CODE"},
                            {sercheable:true, title:"Description", data:"RO"},
                            {sercheable:true, title:"Tax", data:"Tax"},
                             ]
                }).draw()
               
        }
            })
        })


</script>

</html>