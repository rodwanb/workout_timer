import 'package:flutter/material.dart';
import 'package:workouttimer/models/workout_timer.dart';

class WorkoutTimers extends ChangeNotifier {
  List<WorkoutTimer> _items = [];

  WorkoutTimers(this._items);

  List<WorkoutTimer> get items {
    return _items.toList();
  }

  WorkoutTimer findById(String id) {
    return _items.firstWhere((timer) => timer.id == id);
  }

  void add(WorkoutTimer timer) {
    _items.add(timer.copy(id: UniqueKey().toString()));
    notifyListeners();
  }

  void update(String id, WorkoutTimer timer) {
    final index = _items.indexWhere((timer) => timer.id == id);
    if (index >= 0) {
      _items[index] = timer;
      notifyListeners();
    }
  }
}
