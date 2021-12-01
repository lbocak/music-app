<?php
header("Access-Control-Allow-Headers: Authorization, Content-Type");
header("Access-Control-Allow-Origin: *");
header('content-type: application/json; charset=utf-8');

include 'db_connect.php';




$queryResult=$connect->query("
select 
	p.id,
	p.title,
	p.date_of_creation,
	p.image_path,
	p.description,
	concat(first_name, ' ', last_name) as creator
from 
	playlists as p
left join 
	users as u
on	p.user_id = u.id

");


$result = array();


if ($queryResult->num_rows > 0) {
	while($fetchData=$queryResult->fetch_assoc()){
		$result[]=$fetchData;
	}
	echo json_encode($result);
} else {
	echo "error";
}


/*
select 
	p.id,
	p.title,
	p.date_of_creation,
	p.image_path,
	p.description,
	concat(u.first_name, ' ', u.last_name) as creator,
    GROUP_CONCAT(
        CONCAT('Song (', JSON_OBJECT(
        	'id', s.id,
            'title', s.title,
            'duration', s.duration,
            'path', s.path,
            'image_path', s.image_path,
            'artist', a.name,
            'album', al.title
        ), ') ')
    ) as songs
from 
	playlists as p
left join 
	users as u
on	p.user_id = u.id
left join
	songs_in_playlists as sip
on	sip.playlist_id = p.id
left join
	songs as s
on	sip.song_id = s.id
left join 
	artists as a
on 	a.id = s.artist_id
left join 
	albums as al
on 	al.id = s.artist_id
group by
	p.id,
	p.title,
	p.date_of_creation,
	p.image_path,
	p.description,
	concat(u.first_name, ' ', u.last_name)

*/

?>
