<?php header('Content-Type: text/html; charset=utf-8'); 
	$server_name = "localhost";
	$username = "root";
	$password = "";
	$db_name = "music_app"; 

	$connect = mysqli_connect($server_name, $username, $password, $db_name)
	or die('Error encountered when trying to connect to DB.'.mysqli_error());
	 
	mysqli_set_charset($connect, "utf8");
?>