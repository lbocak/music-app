import 'package:flutter/material.dart';
import 'package:music_app/entities/songs.dart';

class CurrentTrackModel extends ChangeNotifier {
  Song? selected;

  void selectTrack(Song track) {
    selected = track;
    notifyListeners();
  }
}
