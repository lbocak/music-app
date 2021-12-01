<?php
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "music_app";
    $table = "songs";

    $action = $_POST['action'];

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }


    if('GET_ALL' == $action){
        $dbdata = array();
        $sql = "
			SELECT 
				id,
				title,
				cast(duration as char) as duration,
				path,
				image_path,
				cast(artist_id as char) as artist,
				cast(album_id as char) as album
			FROM 
				$table as s";
        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                $dbdata[]=$row;
            }
            echo json_encode($dbdata);
        } else {
            echo "error";
        }
        $conn->close();
        return;
    }

    if('ADD' == $action){
        $title = $_POST['title'];
        $duration = $_POST['duration'];
		$path = $_POST['path'];
        $image_path = $_POST['image_path'];
		$artist_id = $_POST['artist_id'];
        $album_id = $_POST['album_id'];
        $sql = "INSERT INTO $table (title, duration, path, image_path, artist_id, album_id) VALUES('$title', $duration, '$path', '$image_path', cast('$artist_id' as int), cast('$album_id' as int))";
        $result = $conn->query($sql);
        echo 'success';
        return;
    }

    if('UPDATE' == $action){
        $id = $_POST['id'];
        $title = $_POST['title'];
        $duration = $_POST['duration'];
		$path = $_POST['path'];
        $image_path = $_POST['image_path'];
		$artist_id = $_POST['artist_id'];
        $album_id = $_POST['album_id'];
        $sql = "
			UPDATE 
				$table 
			SET 
				title = '$title',
				duration = $duration,
				path = '$path',
				image_path = '$image_path',
				artist_id = '$artist_id',
				album_id = '$album_id'				
			WHERE id = $id";
        if ($conn->query($sql) === TRUE) {
            echo "success";
        } else {
            echo "error";
        }
        $conn->close();
        return;
    }

    if('DELETE' == $action){
        $id = $_POST['id'];
        $sql = "DELETE FROM $table WHERE id = $id";
        if ($conn->query($sql) === TRUE) {
            echo "success";
        } else {
            echo "error";
        }
        $conn->close();
        return;
    }
    
?>
