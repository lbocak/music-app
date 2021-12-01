import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/entities/songs.dart';
import 'package:music_app/models/current_track_model.dart';
import 'package:music_app/models/current_track_player.dart';
import 'package:provider/provider.dart';

class CurrentTrack extends StatelessWidget {
  const CurrentTrack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final duration =
        context.watch<CurrentTrackModel>().selected?.duration.toString() ??
            '300';
    final url = context.watch<CurrentTrackModel>().selected?.path.toString() ??
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3';
    return Container(
      height: 84.0,
      width: double.infinity,
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            _TrackInfo(),
            const Spacer(),
            _PlayerControls(
              p_url: url,
              p_duration: duration,
            ),
            const Spacer(),
            if (MediaQuery.of(context).size.width > 800) const _MoreControls(),
          ],
        ),
      ),
    );
  }
}

class _TrackInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selected = context.watch<CurrentTrackModel>().selected;
    if (selected == null) return const SizedBox.shrink();
    return Row(
      children: [
        Image(
          image: NetworkImage(selected.imagePath),
          height: 60.0,
          width: 60.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 12.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              selected.title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 4.0),
            Text(
              selected.artist,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.grey[300], fontSize: 12.0),
            )
          ],
        ),
        const SizedBox(width: 12.0),
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _PlayerControls extends StatefulWidget {
  String p_duration;
  String p_url;

  _PlayerControls({
    Key? key,
    required this.p_duration,
    required this.p_url,
  }) : super(key: key);

  @override
  _AudioPlayerUrlState createState() => _AudioPlayerUrlState();
}

class _AudioPlayerUrlState extends State<_PlayerControls> {
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.STOPPED;

  //String url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3';
  //String url = 'http://localhost/data/Electro-Light%20-%20Symbolism%20%5bNCS%20Release%5d.mp3';
  String url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3';

  /// Optional
  int timeProgress = 0;
  int audioDuration = 300;

  /// Optional
  Widget slider() {
    return SizedBox(
      //  width: 100.0,
      child: Slider.adaptive(
          value: timeProgress.toDouble(),
          max: audioDuration.toDouble(),
          min: 0.0,
          onChanged: (value) {
            seekToSec(value.toInt());
            if (timeProgress.compareTo(audioDuration) == 0) {
              //
            }
          }),
    );
  }

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        playerState = state;
        audioDuration = int.parse(widget.p_duration);
      });
    });

    audioPlayer.setUrl(widget.p_url);
    // Triggers the onDurationChanged listener and sets the max duration string
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inSeconds;
        audioDuration = int.parse(widget.p_duration);
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration position) async {
      setState(() {
        timeProgress = position.inSeconds;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  playMusic() async {
    await audioPlayer.resume();
  }

  pauseMusic() async {
    await audioPlayer.pause();
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    audioPlayer.seek(newPos);
  }

  String getTimeString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString'; // Returns a string with the format mm:ss
  }

  @override
  Widget build(BuildContext context) {
    final selected = context.watch<CurrentTrackModel>().selected;
    // var audioPlayerState;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            IconButton(
              padding: const EdgeInsets.only(),
              icon: const Icon(Icons.shuffle),
              iconSize: 20.0,
              onPressed: () {},
            ),
            IconButton(
              padding: const EdgeInsets.only(),
              icon: const Icon(Icons.skip_previous_outlined),
              iconSize: 20.0,
              onPressed: () {},
            ),
            IconButton(
              padding: const EdgeInsets.only(),
              //  icon: const Icon(Icons.play_circle_outline),
              iconSize: 34.0,
              onPressed: () {
                //  var audioPlayerState;
                playerState == PlayerState.PLAYING ? pauseMusic() : playMusic();
              },
              icon: Icon(playerState == PlayerState.PLAYING
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded),
            ),
            IconButton(
              padding: const EdgeInsets.only(),
              icon: const Icon(Icons.skip_next_outlined),
              iconSize: 20.0,
              onPressed: () {},
            ),
            IconButton(
              padding: const EdgeInsets.only(),
              icon: const Icon(Icons.repeat),
              iconSize: 20.0,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          children: [
            Text(getTimeString(timeProgress),
                style: Theme.of(context).textTheme.caption),
            const SizedBox(width: 8.0),
            Container(
              height: 5.0,
              //   width: MediaQuery.of(context).size.width * 0.3,
              //width: 200.0,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: slider()),
            ),
            const SizedBox(width: 8.0),
            Text(
              //selected?.duration ?? '00:00',
              getTimeString(int.parse(selected?.duration ?? '0')),
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ],
    );
  }
}

class _MoreControls extends StatefulWidget {
  const _MoreControls({Key? key}) : super(key: key);

  @override
  State<_MoreControls> createState() => _MoreControlsState();
}

class _MoreControlsState extends State<_MoreControls> {
  static AudioPlayer advancedPlayer = AudioPlayer();
  static AudioCache player = AudioCache(fixedPlayer: advancedPlayer);
  double _currentSliderValue = 20;

  void changeVolume(double value) {
    advancedPlayer.setVolume(value);
  }

  Widget slider() {
    return SizedBox(
        child: Slider(
      value: _currentSliderValue,
      max: 100.0,
      min: 0.0,
      divisions: 5,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        changeVolume(value);
        setState(() {
          _currentSliderValue = value;
        });
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.devices_outlined),
          iconSize: 20.0,
          onPressed: () {},
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.volume_up_outlined),
              onPressed: () {},
            ),
            SizedBox(
              child: slider(),
              width: 150.0,
              height: 3.0,
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.fullscreen_outlined),
          onPressed: () {},
        ),
      ],
    );
  }
}
