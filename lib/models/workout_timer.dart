import 'package:flutter/material.dart';

class WorkoutTimer with ChangeNotifier {
  final String id;
  final String name;

  WorkoutTimer({
    this.id,
    this.name,
  });

  WorkoutTimer copy({
    id,
    name,
  }) {
    return WorkoutTimer(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
