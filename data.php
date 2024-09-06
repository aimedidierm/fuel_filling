<?php
ini_set('display_errors', 0);
ini_set('display_startup_errors', 0);
error_reporting(0);
require 'php-includes/connect.php';

$query = "SELECT * FROM seller WHERE id=1";
$stmt = $db->prepare($query);
$stmt->execute();
$rows = $stmt->fetch(PDO::FETCH_ASSOC);
$balan = $rows['balance'];
$sellerid = $rows['id'];
if (isset($_REQUEST['money'])) {
    $card = $_REQUEST['card'];
    $amount = $_REQUEST['money'];
    $query = "SELECT * FROM user WHERE card = ? limit 1";
    $stmt = $db->prepare($query);
    $stmt->execute(array($card));
    if ($stmt->rowCount() > 0) {
        $rows = $stmt->fetch(PDO::FETCH_ASSOC);
        $userid = $rows['id'];
        //get price
        $query = "SELECT * FROM consume_allowed";
        $stmt = $db->prepare($query);
        $stmt->execute();
        $rows = $stmt->fetch(PDO::FETCH_ASSOC);
        $cprice = $rows['consume']; //Amount allowed to be consumed
        //get total
        $query = "SELECT * FROM consume WHERE user=? ORDER BY id DESC limit 1";
        $stmt = $db->prepare($query);
        $stmt->execute(array($userid));
        $rows = $stmt->fetch(PDO::FETCH_ASSOC);
        $camount = $rows['total']; //total allowed bonus
        if ($cprice <= $camount) {
            $total = $camount - $amount;
            $sql = "INSERT INTO consume (user,amount,total,seller) VALUES (?,?,?,'1')";
            $stm = $db->prepare($sql);
            if ($stm->execute(array($userid, $amount, $total))) {
                $data = array('cstatus' => $amount);
                echo $response = json_encode($data) . "\n";
            } else {
                $data = array('cstatus' => '3'); //unknown error
                echo $response = json_encode($data) . "\n";
            }
        } else {
            $data = array('cstatus' => '1'); //insufcient balance
            echo $response = json_encode($data) . "\n";
        }
    } else {
        $data = array('cstatus' => '1');
        echo $response = json_encode($data) . "\n"; //user not found
    }
}

if (isset($_REQUEST['dmoney'])) {
    $card = $_REQUEST['card'];
    $amount = $_REQUEST['dmoney'];
    $query = "SELECT * FROM user WHERE card = ? limit 1";
    $stmt = $db->prepare($query);
    $stmt->execute(array($card));
    if ($stmt->rowCount() > 0) {
        $rows = $stmt->fetch(PDO::FETCH_ASSOC);
        $userid = $rows['id'];
        $number = $rows['phone'];
        $user = "test";
        $req = '{"amount":' . $amount . ',"number":"' . $number . '"}';
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
        $cprice = $rows['price'];
        $amountml = (1000 / $cprice) * $amount;
        //get total
        $query = "SELECT * FROM consume WHERE user=? ORDER BY id DESC limit 1";
        $stmt = $db->prepare($query);
        $stmt->execute(array($userid));
        $rows = $stmt->fetch(PDO::FETCH_ASSOC);
        $camount = $rows['total'];
        $total = $camount + $amountml;
        //update data
        $sql = "INSERT INTO consume (user,amount,total,seller) VALUES (?,?,?,'1')";
        $stm = $db->prepare($sql);
        if ($stm->execute(array($userid, $amountml, $total))) {
            $ubalance = $balan + $amount;
            $sql = "UPDATE seller SET balance = ?";
            $stm = $db->prepare($sql);
            $stm->execute(array($ubalance));
            $data = array('cstatus' => $amountml);
            echo $response = json_encode($data) . "\n";
        } else {
            $data = array('cstatus' => '3'); //unkown error
            echo $response = json_encode($data) . "\n";
        }
    } else {
        $data = array('cstatus' => '1'); //User not found
        echo $response = json_encode($data) . "\n";
    }
}

if (isset($_REQUEST['phone'])) {
    $number = $_REQUEST['phone'];
    $amount = $_REQUEST['money'];
    $user = "test";
    $req = '{"amount":' . $amount . ',"number":"' . $number . '"}';
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
    $sql = "INSERT INTO momotr (amount,number,user,status) VALUES (?,?,'0','pending')";
    $stm = $db->prepare($sql);
    if ($stm->execute(array($amount, $number))) {
        $ubalance = $balan + $amount;
        $sql = "UPDATE seller SET balance = ?";
        $stm = $db->prepare($sql);
        $stm->execute(array($ubalance));
        $query = "SELECT * FROM price";
        $stmt = $db->prepare($query);
        $stmt->execute();
        $rows = $stmt->fetch(PDO::FETCH_ASSOC);
        $cprice = $rows['price'];
        $amountml = (1000 / $cprice) * $amount;
        $arr = array('cstatus' => $amountml, 'b' => 2);
        echo $data = json_encode($arr) . "\n";
    } else {
        $arr = array('cstatus' => 1, 'b' => 2);
        echo $data = json_encode($arr) . "\n";
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
