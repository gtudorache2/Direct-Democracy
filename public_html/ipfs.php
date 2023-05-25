<?php
/*ini_set('display_errors', '1');
ini_set('display_startup_errors', '1');
error_reporting(E_ALL);*/

require_once('./vendor/autoload.php');

use Cloutier\PhpIpfsApi\IPFS;

// connect to ipfs daemon API server
$ipfs = new IPFS("localhost", '8080', "5002");

if (isset($_FILES['files']))
{   
  //  echo file_get_contents($_FILES['files']["tmp_name"]);
    $short = $ipfs->add(base64_encode(file_get_contents($_FILES['files']["tmp_name"])));
    echo $short.'|'.$_FILES['files']['name'];
}