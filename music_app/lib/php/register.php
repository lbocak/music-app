<?php
	header("Access-Control-Allow-Headers: Authorization, Content-Type");
	header("Access-Control-Allow-Origin: *");
	header('content-type: application/json; charset=utf-8');
	
    include 'db_connect.php';
	
	$first_name = $_POST['first_name'];
	$last_name = $_POST['last_name'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    
    
    $connect->query("INSERT INTO users (first_name, last_name, email, password) VALUES ('".$first_name."','".$last_name."','".$email."','".$password."')");
	
	echo json_encode('{"status": true}');
?>
