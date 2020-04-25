import 'package:flutter/material.dart';

class AddEditWorkoutTimer extends StatelessWidget {
  static const routeName = '/add-edit-workout-timer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Workout Timer"),
      ),
      body: Center(
        child: const Text('Add workout timer here.'),
      ),
    );
  }
}
