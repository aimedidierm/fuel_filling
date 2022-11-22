<?php
ini_set('display_errors',1);
ini_set('display_startup_errors',1);
error_reporting(E_ALL);
require 'php-includes/connect.php';
$sellerid=1;
$newamount=0;
if(isset($_GET['#'])){
    $card = $_GET['#'];
    $amount = $_GET['amount'];
    //$card = '1';
    //$amount = 1000;
    $query = "SELECT balance,id FROM user WHERE card = ? limit 1";
    $stmt = $db->prepare($query);
    $stmt->execute(array($card));
    $rows = $stmt->fetch(PDO::FETCH_ASSOC);
    $user=$rows['id'];
    if ($stmt->rowCount()>0) {
        if ($amount <= $rows['balance']) {
            $newamount=$rows['balance']-$amount;
            $sql ="UPDATE user SET balance = ? WHERE card = ? limit 1";
            $stm = $db->prepare($sql);
            if ($stm->execute(array($newamount, $card))) {
                $query = "SELECT price FROM price limit 1";
                $stmt = $db->prepare($query);
                $stmt->execute();
                $rows = $stmt->fetch(PDO::FETCH_ASSOC);
                $mount = $amount/$rows['price'];
                $sql ="INSERT INTO transactions (credit,user) VALUES (?,?)";
                $stm = $db->prepare($sql);
                $stm->execute(array($amount,$user));
                
                $query = "SELECT balance FROM seller WHERE id = ? limit 1";
                $stmt = $db->prepare($query);
                $stmt->execute(array($sellerid));
                $rows = $stmt->fetch(PDO::FETCH_ASSOC);
                $sebal=$rows['balance'];
                $newselbal=$sebal+$amount;
                $sql ="UPDATE seller SET balance = ? WHERE id = ? limit 1";
                $stm = $db->prepare($sql);
                $stm->execute(array($newselbal,$sellerid));

                $data = array('outml' =>$mount); 
                echo $response = json_encode($data);
            }
        } else {
            $data = array('outml' =>'0'); 
            echo $response = json_encode($data);
        }
    }
}
if(isset($_GET['money'])){
    $card = $_GET['card'];
    $money = $_GET['money'];
    //$card = 'F3 65 AB AB';
    //$money = '100';
    $query = "SELECT id FROM user WHERE card = ? limit 1";
    $stmt = $db->prepare($query);
    $stmt->execute(array($card));
    $rows = $stmt->fetch(PDO::FETCH_ASSOC);
    $user=$rows['id'];
    $query = "SELECT * FROM consume WHERE user = ? limit 1";
    $stmt = $db->prepare($query);
    $stmt->execute(array($user));
    $rows = $stmt->fetch(PDO::FETCH_ASSOC);
    $am=$rows['amount'];
    if ($stmt->rowCount()>0) {
        if ($money <= $am) {
            $newamount=$am-$money;
            $sql ="UPDATE consume SET amount = ? WHERE user = ? limit 1";
            $stm = $db->prepare($sql);
            if ($stm->execute(array($newamount, $user))) {
                $data = array('outml' =>$money); 
                echo $response = json_encode($data);
            }
        } else {
            $data = array('outml' =>'0'); 
            echo $response = json_encode($data);
        }
    }
}
if(isset($_GET['phone'])){
    $number=$_GET['phone'];
    $amount=$_GET['amount'];
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
    $sql ="INSERT INTO momotr (amount,number,user,status) VALUES (?,?,?,'pending')";
    $stm = $db->prepare($sql);
    if ($stm->execute(array($amount,$number,$user))) {
        echo $data = array('outml' =>$money); 
        echo $response = json_encode($data);
    } else{
        echo $data = array('outml' =>'0'); 
        echo $response = json_encode($data);
}
}
function getToken() {
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
      CURLOPT_POSTFIELDS => '{"client_id": "89f8e714-0f47-11ed-babe-dead0062f58a","client_secret": "afc73b804eee90103e2c8caad4741393da39a3ee5e6b4b0d3255bfef95601890afd80709"}',
      CURLOPT_HTTPHEADER => array('Content-Type: application/json'),
    ));
  
    $response = curl_exec($curl);
  
    curl_close($curl);
  
    return json_decode($response)->access;
}
?>