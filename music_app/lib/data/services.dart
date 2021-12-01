import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/entities/songs.dart';
import 'package:music_app/entities/playlists.dart';

class Services {
  static const String ROOT = 'http://localhost/music_app/crud_actions.php';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _ADD_ACTION = 'ADD';
  static const String _UPDATE_ACTION = 'UPDATE';
  static const String _DELETE_ACTION = 'DELETE';

  static Future<List<Song>> getSongs() async {
    try {
      String url = "http://localhost/music_app/get_songs_data.php";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<Song> list = parseSongs(response.body);
        return list;
      } else {
        throw <Song>[];
      }
    } catch (e) {
      return <Song>[];
    }
  }

  static Future<List<Song>> getSongsTable() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("getSongsTable >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Song> list = parseSongs(response.body);
        return list;
      } else {
        throw <Song>[];
      }
    } catch (e) {
      return <Song>[];
    }
  }

  static Future<List<Playlist>> getPlaylists() async {
    try {
      String url = "http://localhost/music_app/get_playlist_data.php";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<Playlist> list = parsePlaylists(response.body);
        return list;
      } else {
        throw <Playlist>[];
      }
    } catch (e) {
      return <Playlist>[];
    }
  }

  static List<Song> parseSongs(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Song>((json) => Song.fromJson(json)).toList();
  }

  static List<Playlist> parsePlaylists(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Playlist>((json) => Playlist.fromJson(json)).toList();
  }

  static Future<String> addSong(String title, String duration, String path,
      String imagePath, String artistId, String albumId) async {
    try {
      var map = Map<String, dynamic>();
      map["action"] = _ADD_ACTION;
      map["title"] = title;
      map["duration"] = duration;
      map["path"] = path;
      map["image_path"] = imagePath;
      map["artist_id"] = artistId;
      map["album_id"] = albumId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("addSong >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateSong(String id, String title, String duration,
      String path, String imagePath, String artistId, String albumId) async {
    try {
      var map = Map<String, dynamic>();
      map["action"] = _UPDATE_ACTION;
      map["id"] = id;
      map["title"] = title;
      map["duration"] = duration;
      map["path"] = path;
      map["image_path"] = imagePath;
      map["artist_id"] = artistId;
      map["album_id"] = albumId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("deleteSong >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deleteSong(String id) async {
    try {
      var map = Map<String, dynamic>();
      map["action"] = _DELETE_ACTION;
      map["id"] = id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("deleteSong >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
}
