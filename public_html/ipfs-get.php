<?php
/*ini_set('display_errors', '1');
ini_set('display_startup_errors', '1');
error_reporting(E_ALL);*/
header('Content-disposition: attachment; filename="'.explode('|', $_GET['hash'])[1].'"');
require_once('./vendor/autoload.php');

use Cloutier\PhpIpfsApi\IPFS;

// connect to ipfs daemon API server
$ipfs = new IPFS("localhost", '8080', "5002");

if (isset($_GET['hash']))
{   
  //  echo file_get_contents($_FILES['files']["tmp_name"]);
    echo base64_decode($ipfs->cat(explode('|', $_GET['hash'])[0]));
}