import 'package:flutter/material.dart';
import 'package:workouttimer/screens/add_edit_workout_timer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Timer'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddEditWorkoutTimer.routeName);
            },
          )
        ],
      ),
      body: Center(
        child: const Text("Empty"),
      ),
    );
  }
}
