import 'dart:async';

import 'package:flutter/foundation.dart';

class WorkoutTimer with ChangeNotifier {
  Timer _timer;
  int _duration = 30;
  int _ticker = 0;

  int get duration {
    return _duration;
  }

  int get ticker {
    return _ticker;
  }

  bool get isRunning {
    return _timer == null ? false : _timer.isActive;
  }

  void setDuration(int duration) {
    _duration = duration;
    notifyListeners();
  }

  void startTimer() {
    _ticker = _duration;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print('tick: $_ticker');
      if (_ticker <= 0) {
        _ticker = _duration;
      } else {
        _ticker--;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void stopTimer() {
    _timer.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
}
