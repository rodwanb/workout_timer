import 'dart:async';

import 'package:flutter/foundation.dart';

class Time with ChangeNotifier {
  final int duration;

  int _elapsedSeconds = 0;
  Timer _timer;
  bool _isPaused = false;

  Time({@required this.duration});

  @override
  void dispose() {
    pause();
    super.dispose();
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
      _elapsedSeconds = duration;
    }
    _isPaused = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print('elapsedSeconds: $_elapsedSeconds');
      if (_isTimeLapsed()) {
        pause();
        _elapsedSeconds = duration;
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
}
