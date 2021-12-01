<?php
header("Access-Control-Allow-Headers: Authorization, Content-Type");
header("Access-Control-Allow-Origin: *");
header('content-type: application/json; charset=utf-8');

include 'db_connect.php';


//$id = $_GET['id'];

$queryResult=$connect->query("
SELECT 
	s.id as id,
	s.title as title,
	cast(duration as char) as duration,
	path,
	image_path,
	a.name as artist,
	al.title as album
FROM 
	songs as s
left join 
	artists as a
on	s.artist_id = a.id
left join
	albums as al
on	s.album_id = al.id
order by
	CAST(REGEXP_SUBSTR(s.title,'[0-9]+') as int)");

$result=array();


if ($queryResult->num_rows > 0) {
	while($fetchData=$queryResult->fetch_assoc()){
		$result[]=$fetchData;
	}
	echo json_encode($result);
} else {
	echo "error";
}



?>
