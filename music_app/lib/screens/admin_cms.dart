import 'package:flutter/material.dart';
import 'package:music_app/entities/songs.dart';
import 'package:music_app/data/Services.dart';
import 'package:music_app/landing_page.dart';
import 'package:music_app/widgets/widgets.dart';

class AdminApp extends StatefulWidget {
  const AdminApp() : super();

  final String title = "Flutter Data Table";

  @override
  AdminAppState createState() => AdminAppState();
}

class AdminAppState extends State<AdminApp> {
  List<Song> _songs = [];
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _title;
  late TextEditingController _duration;
  late TextEditingController _songPath;
  late TextEditingController _imagePath;
  late TextEditingController _artist;
  late TextEditingController _album;
  late Song _selectedSong;
  late bool _isUpdating;
  late String _titleProgress;

  @override
  void initState() {
    super.initState();
    _songs = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _title = TextEditingController();
    _duration = TextEditingController();
    _songPath = TextEditingController();
    _imagePath = TextEditingController();
    _artist = TextEditingController();
    _album = TextEditingController();
    _getSongs();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _getSongs() {
    _showProgress('Loading Songs...');
    Services.getSongsTable().then((songs) {
      setState(() {
        _songs = songs;
      });
      _showProgress(widget.title);
      print("Length: ${songs.length}");
    });
  }

  _addSong() {
    if (_title.text.trim().isEmpty ||
        _duration.text.trim().isEmpty ||
        _songPath.text.trim().isEmpty ||
        _imagePath.text.trim().isEmpty ||
        _artist.text.trim().isEmpty ||
        _album.text.trim().isEmpty) {
      print("Empty fields");
      return;
    }

    _showProgress('Adding Song...');
    Services.addSong(_title.text, _duration.text, _songPath.text,
            _imagePath.text, _artist.text, _album.text)
        .then((result) {
      if ('success' == result) {
        _getSongs();
      }
      _clearValues();
    });
  }

  _deleteSong(Song song) {
    _showProgress('Deleting Song...');
    Services.deleteSong(song.id).then((result) {
      if ('success' == result) {
        setState(() {
          _songs.remove(song);
        });
        _getSongs();
      }
    });
  }

  _updateSong(Song song) {
    _showProgress('Updating Song...');
    Services.updateSong(song.id, _title.text, _duration.text, _songPath.text,
            _imagePath.text, _artist.text, _album.text)
        .then((result) {
      if ('success' == result) {
        _getSongs();
        setState(() {
          _isUpdating = false;
        });
        _title.text = '';
        _duration.text = '';
        _songPath.text = '';
        _imagePath.text = '';
        _artist.text = '';
        _album.text = '';
      }
    });
  }

  _setValues(Song song) {
    _title.text = song.title;
    _duration.text = song.duration;
    _songPath.text = song.path;
    _imagePath.text = song.imagePath;
    _artist.text = song.artist;
    _album.text = song.album;
    setState(() {
      _isUpdating = true;
    });
  }

  _clearValues() {
    _title.text = '';
    _duration.text = '';
    _songPath.text = '';
    _imagePath.text = '';
    _artist.text = '';
    _album.text = '';
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("ID"), numeric: false, tooltip: "Song id"),
            DataColumn(
                label: Text(
                  "TITLE",
                ),
                numeric: false,
                tooltip: "Title"),
            DataColumn(
                label: Text("DURATION"), numeric: false, tooltip: "Duration"),
            DataColumn(
                label: Text("PATH"), numeric: false, tooltip: "Song path"),
            DataColumn(
                label: Text("IMAGE PATH"),
                numeric: false,
                tooltip: "Image path"),
            DataColumn(
                label: Text("ARTIST ID"), numeric: false, tooltip: "Artist id"),
            DataColumn(
                label: Text("ALBUM ID"), numeric: false, tooltip: "Album id"),
            DataColumn(
                label: Text("DELETE"),
                numeric: false,
                tooltip: "Delete Action"),
          ],
          rows: _songs
              .map(
                (song) => DataRow(
                  cells: [
                    DataCell(
                      Text(song.id),
                      onTap: () {
                        print("Tapped " + song.id);
                        _setValues(song);
                        _selectedSong = song;
                      },
                    ),
                    DataCell(
                      Text(
                        song.title.toUpperCase(),
                      ),
                      onTap: () {
                        print("Tapped " + song.title);
                        _setValues(song);
                        _selectedSong = song;
                      },
                    ),
                    DataCell(
                      Text(
                        song.duration,
                      ),
                      onTap: () {
                        print("Tapped " + song.duration);
                        _setValues(song);
                        _selectedSong = song;
                      },
                    ),
                    DataCell(
                      Text(
                        song.path,
                      ),
                      onTap: () {
                        print("Tapped " + song.path);
                        _setValues(song);
                        _selectedSong = song;
                      },
                    ),
                    DataCell(
                      Text(
                        song.imagePath,
                      ),
                      onTap: () {
                        print("Tapped " + song.imagePath);
                        _setValues(song);
                        _selectedSong = song;
                      },
                    ),
                    DataCell(
                      Text(
                        song.artist,
                      ),
                      onTap: () {
                        print("Tapped " + song.artist);
                        _setValues(song);
                        _selectedSong = song;
                      },
                    ),
                    DataCell(
                      Text(
                        song.album,
                      ),
                      onTap: () {
                        print("Tapped " + song.album);
                        _setValues(song);
                        _selectedSong = song;
                      },
                    ),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteSong(song);
                        },
                      ),
                      onTap: () {
                        print("Tapped " + song.title);
                      },
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  showSnackBar(context, message) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      key: _scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MusicApp()));
            },
            child: Container(
              padding: const EdgeInsets.all(6.0),
              decoration: const BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chevron_left,
                size: 28.0,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _title,
              decoration: const InputDecoration.collapsed(
                hintText: "Title",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _duration,
              decoration: const InputDecoration.collapsed(
                hintText: "Duration",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _songPath,
              decoration: const InputDecoration.collapsed(
                hintText: "Path",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _imagePath,
              decoration: const InputDecoration.collapsed(
                hintText: "Image path",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _artist,
              decoration: const InputDecoration.collapsed(
                hintText: "Artist",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _album,
              decoration: const InputDecoration.collapsed(
                hintText: "Album",
              ),
            ),
          ),
          //       _isUpdating ?
          Row(
            children: <Widget>[
              OutlinedButton(
                child: const Text('UPDATE'),
                onPressed: () {
                  _updateSong(_selectedSong);
                },
              ),
              OutlinedButton(
                child: const Text('INSERT'),
                onPressed: () {
                  _addSong();
                },
              ),
              OutlinedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    _isUpdating = false;
                  });
                  _clearValues();
                },
              ),
            ],
          ),
          // : Container(),
          Expanded(
            child: _dataBody(),
          )
        ],
      ),
    );
  }
}
