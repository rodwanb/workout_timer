import 'dart:async';

import 'package:flutter/foundation.dart';

enum TimeMode {
  work,
  rest
}

class Time with ChangeNotifier {
  final int duration;
  final int rest;

  int _elapsedSeconds = 0;
  Timer _timer;
  bool _isPaused = false;
  TimeMode _timeMode = TimeMode.work;

  Time({this.duration = 30, this.rest = 10}) {
    _elapsedSeconds = duration;
  }

  @override
  void dispose() {
    pause();
    super.dispose();
  }

  TimeMode get mode {
    return _timeMode;
  }

  int get ticker {
    return _elapsedSeconds;
  }

  bool get isRunning {
    return _timer == null ? false : _timer.isActive;
  }

  void start() {
    print('starting timer');
    if (!_isPaused) {
      if (_timeMode == TimeMode.work) {
        _elapsedSeconds = duration;
      } else {
        _elapsedSeconds = rest;
      }
    }
    _isPaused = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print('elapsedSeconds: $_elapsedSeconds');
      if (_isTimeLapsed()) {
        _timer.cancel();
        switchMode();
        start();
      } else {
        _elapsedSeconds--;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void pause() {
    print('pausing timer');
    _isPaused = true;
    _timer.cancel();
    notifyListeners();
  }

  bool _isTimeLapsed() => _elapsedSeconds <= 0;

  void switchMode() {
    switch (_timeMode) {
      case TimeMode.work:
        _timeMode = TimeMode.rest;
        break;
      case TimeMode.rest:
        _timeMode = TimeMode.work;
        break;
    }
    notifyListeners();
  }
}
