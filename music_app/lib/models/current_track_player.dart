import 'package:flutter/material.dart';

class CurrentTrackPlayer extends ChangeNotifier {
  bool changed = false;

  void changedSong(bool _changed) {
    changed = _changed;
    notifyListeners();
  }
}
