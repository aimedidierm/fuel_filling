<?php
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL);
require 'php-includes/connect.php';

$query = "SELECT * FROM seller WHERE id=1";
$stmt = $db->prepare($query);
$stmt->execute();
$rows = $stmt->fetch(PDO::FETCH_ASSOC);
$balan = $rows['balance'];
$sellerid = $rows['id'];

if(isset($_REQUEST['phone'])){
    $number=$_REQUEST['phone'];
    $amount=$_REQUEST['money'];
    $user="test";
    $req = '{"amount":'.$amount.',"number":"'.$number.'"}';
    define('BASE_URL', 'https://payments.paypack.rw/api');
    
    $curl = curl_init();
    
    curl_setopt_array($curl, array(
      CURLOPT_URL => BASE_URL . '/transactions/cashin?Idempotency-Key=OldbBsHAwAdcYalKLXuiMcqRrdEcDGRv',
      CURLOPT_RETURNTRANSFER => true,
      CURLOPT_ENCODING => '',
      CURLOPT_MAXREDIRS => 10,
      CURLOPT_TIMEOUT => 0,
      CURLOPT_FOLLOWLOCATION => true,
      CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
      CURLOPT_CUSTOMREQUEST => 'POST',
      CURLOPT_POSTFIELDS => $req,
      CURLOPT_HTTPHEADER => array(
        'Authorization: Bearer ' . getToken(),
        'Content-Type: application/json'
      ),
    ));
    
    $response = curl_exec($curl);
    
    curl_close($curl);
    $sql ="INSERT INTO momotr (amount,number,user,status) VALUES (?,?,'0','pending')";
    $stm = $db->prepare($sql);
    if ($stm->execute(array($amount,$number))) {
        $ubalance=$balan+$amount;
        $sql ="UPDATE seller SET balance = ?";
        $stm = $db->prepare($sql);
        $stm->execute(array($ubalance));
        $query = "SELECT * FROM price";
        $stmt = $db->prepare($query);
        $stmt->execute();
        $rows = $stmt->fetch(PDO::FETCH_ASSOC);
        $cprice=$rows['price'];
        $amountml=(1000/$cprice)*$amount;
        $arr = array('cstatus' => $amountml,'b' => 2);
        echo $data = json_encode($arr)."\n";
    } else{
        $arr = array('cstatus' => 1,'b' => 2);
        echo $data = json_encode($arr)."\n";
    }
}

function getToken()
{
    $curl = curl_init();

    curl_setopt_array($curl, array(
        CURLOPT_URL => BASE_URL . '/auth/agents/authorize',
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => '{"client_id": "XXX","client_secret": "XXX"}',
        CURLOPT_HTTPHEADER => array('Content-Type: application/json'),
    ));

    $response = curl_exec($curl);

    curl_close($curl);

    return json_decode($response)->access;
}
