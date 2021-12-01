import 'package:flutter/material.dart';
import 'package:music_app/data/services.dart';
import 'package:music_app/entities/playlists.dart';
import 'package:music_app/entities/songs.dart';
import 'package:music_app/landing_page.dart';
import 'package:music_app/login.dart';
import 'package:music_app/widgets/widgets.dart';

class PlaylistScreen extends StatefulWidget {
  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  ScrollController? _scrollController;
  List<Playlist> _playlist = [
    Playlist(
        id: '1',
        title: 'title',
        imagePath: 'assets/artwork.jpg',
        description: 'description',
        creator: 'creator')
  ];
  List<Song> _song = [
    Song(
        id: 'id',
        title: 'title',
        path: 'path',
        imagePath: 'assets/artwork.jpg',
        artist: 'artist',
        album: 'album',
        duration: 'duration')
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _playlist;
    _getPlaylist();
    _getSongs();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  _getPlaylist() {
    Services.getPlaylists().then((List<Playlist> playlist) {
      setState(() {
        _playlist = playlist;
      });
    });
  }

  _getSongs() {
    Services.getSongs().then((song) {
      setState(() {
        _song = song;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 140.0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MusicApp()));
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
            ],
          ),
        ),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle_outlined,
              size: 30.0,
            ),
            label: const Text('Lovro Bocak'),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            padding: const EdgeInsets.only(),
            icon: const Icon(Icons.logout, size: 30.0),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF15AF10),
              Theme.of(context).backgroundColor,
            ],
            stops: const [0, 0.3],
          ),
        ),
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 60.0,
            ),
            children: [
              PlaylistHeader(playlist: _playlist),
              TracksList(tracks: _song),
            ],
          ),
        ),
      ),
    );
  }
}
