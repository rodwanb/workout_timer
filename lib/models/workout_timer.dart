import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

class WorkoutTimer with ChangeNotifier {
  final String id;
  final String name;
  final Duration countdownDuration;
  final Duration warmUpDuration;
  final Duration exerciseDuration;
  final Duration changeOverDuration;
  final Duration restDuration;
  final Duration coolDownDuration;
  final int numberOfSets;
  final int numberOfRounds;

  Queue<Step> _steps = Queue<Step>();
  int _remainingSeconds = 0;
  Timer _timer;
  bool _isPaused = false;
  Step _currentStep;

  WorkoutTimer({@required this.id,
    @required this.name,
    @required this.countdownDuration,
    @required this.warmUpDuration,
    @required this.exerciseDuration,
    @required this.changeOverDuration,
    @required this.restDuration,
    @required this.coolDownDuration,
    @required this.numberOfSets,
    @required this.numberOfRounds}) {
    if (_hasDuration(countdownDuration)) {
      _steps.addLast(Step(name: 'Countdown', duration: countdownDuration));
    }

    if (_hasDuration(warmUpDuration)) {
      _steps.addLast(Step(name: 'Warm up', duration: warmUpDuration));
    }

    for (var round = 0; round < numberOfRounds; round++) {
      if (round != 0 && _hasDuration(restDuration)) {
        _steps.addLast(Step(name: 'Rest', duration: restDuration));
      }
      for (var set = 0; set < numberOfSets; set++) {
        if (_hasDuration(exerciseDuration)) {
          _steps.addLast(Step(name: 'Exercise', duration: exerciseDuration));
        }
        if (set < numberOfSets - 1) {
          if (_hasDuration(changeOverDuration)) {
            _steps.addLast(Step(name: 'Change', duration: changeOverDuration));
          }
        }
      }
    }

    if (_hasDuration(coolDownDuration)) {
      _steps.addLast(Step(name: 'Cool down', duration: coolDownDuration));
    }

    _currentStep = _steps.removeFirst();
    _remainingSeconds = _currentStep.duration.inSeconds;
  }

  WorkoutTimer.standard()
      : this.id = null,
        this.name = null,
        this.countdownDuration = Duration(seconds: 3),
        this.warmUpDuration = Duration(seconds: 10),
        this.exerciseDuration = Duration(seconds: 30),
        this.changeOverDuration = Duration(seconds: 10),
        this.restDuration = Duration(seconds: 90),
        this.coolDownDuration = Duration(seconds: 120),
        this.numberOfSets = 3,
        this.numberOfRounds = 1;

  Duration get totalDuration {
    final countdownSeconds = countdownDuration?.inSeconds ?? 0;
    final warmUpSeconds = warmUpDuration?.inSeconds ?? 0;
    final exerciseSeconds = exerciseDuration?.inSeconds ?? 0;
    final changeOverSeconds = changeOverDuration?.inSeconds ?? 0;
    final restSeconds = restDuration?.inSeconds ?? 0;
    final coolDownSeconds = coolDownDuration?.inSeconds ?? 0;
    final sets = numberOfSets > 0 ? numberOfSets : 1;
    final rounds = numberOfRounds > 0 ? numberOfRounds : 1;
    final totalSeconds = countdownSeconds +
        warmUpSeconds +
        ((((exerciseSeconds + changeOverSeconds) * sets) + restSeconds) *
            rounds) +
        coolDownSeconds;

    print('totalSeconds: $totalSeconds');

    return Duration(seconds: totalSeconds);
  }

  Step get currentStep {
    return _currentStep;
  }

  bool get isRunning {
    return _timer == null ? false : _timer.isActive;
  }

  int get remainingSeconds {
    return _remainingSeconds;
  }

  WorkoutTimer copyWith({id,
    name,
    countdownDuration,
    warmUpDuration,
    exerciseDuration,
    changeOverDuration,
    restDuration,
    coolDownDuration,
    numberOfSets,
    numberOfRounds}) {
    return WorkoutTimer(
        id: id ?? this.id,
        name: name ?? this.name,
        countdownDuration: countdownDuration ?? this.countdownDuration,
        warmUpDuration: warmUpDuration ?? this.warmUpDuration,
        exerciseDuration: exerciseDuration ?? this.exerciseDuration,
        changeOverDuration: changeOverDuration ?? this.changeOverDuration,
        restDuration: restDuration ?? this.restDuration,
        coolDownDuration: coolDownDuration ?? this.coolDownDuration,
        numberOfSets: numberOfSets ?? this.numberOfSets,
        numberOfRounds: numberOfRounds ?? this.numberOfRounds);
  }

  void start() {
    if (!_isPaused) {
      _remainingSeconds = _currentStep.duration.inSeconds;
    }
    _isPaused = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        _timer.cancel();
        if (_steps.isNotEmpty) {
          _currentStep = _steps.removeFirst();
          start();
        } else {
          print('times up');
        }
      } else {
        _remainingSeconds--;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void pause() {
    _isPaused = true;
    _timer.cancel();
    notifyListeners();
  }

  bool _hasDuration(Duration duration) =>
      duration != null && duration.inSeconds > 0;
}

class Step {
  final String name;
  final Duration duration;

  const Step({
    @required this.name,
    @required this.duration,
  });
}
