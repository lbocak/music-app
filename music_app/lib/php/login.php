<?php
	header("Access-Control-Allow-Headers: Authorization, Content-Type");
	header("Access-Control-Allow-Origin: *");
	header('content-type: application/json; charset=utf-8');

    include 'db_connect.php';

    $email = $_POST['email'];
    $password = $_POST['password'];

/*
    $email = 'lbocak@tvz.hr';
    $password = '12345678';
*/

    $sql=$connect->query("SELECT * FROM users WHERE email = '".$email."' AND password = '".$password."'");


    $result=array();

    while($extractData=$sql->fetch_assoc()){
        $result[]=$extractData;
    }

    echo json_encode($result);
?>
