<?php
   ini_set('display_errors', 1); ini_set('display_startup_errors', 1); error_reporting(E_ALL);
   require_once('vendor/autoload.php');

   use Web3\Web3;
   use Web3\Contract;

    if (isset($_POST['SSN']))
    {
      // var_dump($_POST);
        $abi = json_decode(file_get_contents("../data/auth.abi"));
        $contractAddress = "0x5337A7482c89f53e97a306Ea78fE64DA4cF2D6ed";
        $contract = new Contract('http://localhost:8545', $abi);      
        $web3 = new Web3('http://localhost:8545');
        $web3->eth->accounts(function ($err, $accounts) use ($contract) {
            global $contractAddress;
            $fromAccount = $accounts[0];
         echo $fromAccount;
         //var_dump($_POST);
         $p = $_POST;
        // $p['addr'] = Address($p['addr']);
        try
        {  
        $contract->at($contractAddress)->send('createAccount', $p['fullName'], (string)$p['SSN'], $p['homeAddress'],
            $p['pass'], (int)$p['accountType'], (string)$p['phone'], $p['addr'], $p['companyCode'], [
                'from' => $accounts[0],
                'value'=> 10000,
                'gas' =>  300000,
                'gasLimit' => 3000000
            ], function($err, $e1) use ($contract, $fromAccount, $contractAddress) {
                global $contract;
                global $web3;
                if ($err != null)
                {
                   echo 'Error :'.$err;
                   exit();
                }
                else
                {
                    echo '<script>window.location.href="./login.php?msg=Signed%20up%20successfully"</script>';
                }


            });
        }
        catch(Exception $e)
        {
            var_dump($e);
        }


    });
    }
?>
<html>
    <head>
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
    <?php 
        require_once('menu.php');
        ?>
<form method="POST">
    <input type="text" name="fullName" placeholder="Full Name"><br>
    <input type="text" name="SSN" placeholder="SSN"><br>
    <textarea name="homeAddress" placeholder="Complete address"></textarea><br>
    <input type="password" name="pass" placeholder="Password"><br>
    <select name="accountType" placeholder="Account type">
        <option value="0">Personal</option>
        <option value="1">LLC (Limited Liability Company)</option>
        <option value="2">Company</option>
        <option value="3">Individual Business</option>
        <option value="4">Foreign branch</option>
    </select>
    <input type="text" name="phone" placeholder="Phone number"><br>
    <input type="text" name="addr" id="addr" placeholder="Ethereum Address"><br>
    <input type="text" name="companyCode" placeholder="Company code (optional)"><br>
    <button>Sign Up</button>
</form>
</body>
<script defer>
$(document).ready(function()  {
    $('#addr').val(account.address)
})
</script>
</html>