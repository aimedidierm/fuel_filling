<?php
ini_set('display_errors',1);
ini_set('display_startup_errors',1);
error_reporting(E_ALL);
require 'php-includes/connect.php';
if(isset($_POST['test1'])){
    $sql ="INSERT INTO momotr (amount,number,user,status) VALUES ('1','1','0','pending')";
    $stm = $db->prepare($sql);
    if ($stm->execute(array())) {
        echo "hi";
    }
}
?>