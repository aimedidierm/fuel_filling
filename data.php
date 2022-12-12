<?php
ini_set('display_errors',1);
ini_set('display_startup_errors',1);
error_reporting(E_ALL);
require 'php-includes/connect.php';

$query = "SELECT * FROM seller WHERE id=1";
$stmt = $db->prepare($query);
$stmt->execute();
$rows = $stmt->fetch(PDO::FETCH_ASSOC);
$balan=$rows['balance'];
$sellerid=$rows['id'];
if(isset($_POST['money'])){
    //$card=$_POST['card'];
    $card="13 13 BD AB";
    $amount=$_POST['money'];
    $query = "SELECT * FROM user WHERE card = ? limit 1";
    $stmt = $db->prepare($query);
    $stmt->execute(array($card));
    if ($stmt->rowCount()>0) {
        $rows = $stmt->fetch(PDO::FETCH_ASSOC);
        $userid=$rows['id'];
        //get price
        $query = "SELECT * FROM consume_allowed";
        $stmt = $db->prepare($query);
        $stmt->execute();
        $rows = $stmt->fetch(PDO::FETCH_ASSOC);
        $cprice=$rows['consume'];
        //get total
        $query = "SELECT * FROM consume WHERE user=? ORDER BY id DESC limit 1";
        $stmt = $db->prepare($query);
        $stmt->execute(array($userid));
        $rows = $stmt->fetch(PDO::FETCH_ASSOC);
        $camount=$rows['total'];
        if($cprice<=$camount){
            $total=$camount-$amount;
            $sql ="INSERT INTO consume (user,amount,total,seller) VALUES (?,?,?,'1')";
            $stm = $db->prepare($sql);
            if ($stm->execute(array($userid,$amount,$total))) {
                $data = array('cstatus' =>$amount); 
                echo $response = json_encode($data)."\n";
            } else{
                $data = array('cstatus' =>'4'); 
                echo $response = json_encode($data)."\n";
            }
        } else {
            $data = array('cstatus' =>'3'); 
            echo $response = json_encode($data)."\n";
        }
    } else{
        $data = array('cstatus' =>'2'); 
        echo $response = json_encode($data)."\n";
    }
}

if(isset($_POST['dmoney'])){
    //$card=$_POST['card'];
    $card="13 13 BD AB";
    $amount=$_POST['dmoney'];
    $query = "SELECT * FROM user WHERE card = ? limit 1";
    $stmt = $db->prepare($query);
    $stmt->execute(array($card));
    if ($stmt->rowCount()>0) {
        $rows = $stmt->fetch(PDO::FETCH_ASSOC);
        $userid=$rows['id'];
        $number=$rows['phone'];
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
        //get price
        $query = "SELECT * FROM price";
        $stmt = $db->prepare($query);
        $stmt->execute();
        $rows = $stmt->fetch(PDO::FETCH_ASSOC);
        $cprice=$rows['price'];
        $amountml=(1000/$cprice)*$amount;
        //get total
        $query = "SELECT * FROM consume WHERE user=? ORDER BY id DESC limit 1";
        $stmt = $db->prepare($query);
        $stmt->execute(array($userid));
        $rows = $stmt->fetch(PDO::FETCH_ASSOC);
        $camount=$rows['total'];
        $total=$camount+$amountml;
        //update data
        $sql ="INSERT INTO consume (user,amount,total,seller) VALUES (?,?,?,'1')";
        $stm = $db->prepare($sql);
        if ($stm->execute(array($userid,$amountml,$total))) {
            $ubalance=$balan+$amount;
            $sql ="UPDATE seller SET balance = ?";
            $stm = $db->prepare($sql);
            $stm->execute(array($ubalance));
            $data = array('cstatus' =>$amountml); 
            echo $response = json_encode($data)."\n";
        } else{
            $data = array('cstatus' =>'1'); 
            echo $response = json_encode($data)."\n";
        }
    } else{
        $data = array('cstatus' =>'1'); 
        echo $response = json_encode($data)."\n";
    }
}

if(isset($_POST['phone'])){
    $number=$_POST['phone'];
    $amount=$_POST['amount'];
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
        $arr = array('c' => $amountml,'b' => 2);
        echo $data = json_encode($arr)."\n";
    } else{
        $arr = array('c' => 1,'b' => 2);
        echo $data = json_encode($arr)."\n";
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
      //CURLOPT_POSTFIELDS => '{"client_id": "89f8e714-0f47-11ed-babe-dead0062f58a","client_secret": "afc73b804eee90103e2c8caad4741393da39a3ee5e6b4b0d3255bfef95601890afd80709"}',
      CURLOPT_POSTFIELDS => '{"client_id": "0703bed4-7346-11ed-86b2-dead64802bd2","client_secret": "59aa9230bd76a8fb67057440a4be8a7cda39a3ee5e6b4b0d3255bfef95601890afd80709"}',
      CURLOPT_HTTPHEADER => array('Content-Type: application/json'),
    ));
  
    $response = curl_exec($curl);
  
    curl_close($curl);
  
    return json_decode($response)->access;
}
?>