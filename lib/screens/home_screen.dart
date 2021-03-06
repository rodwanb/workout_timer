import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttimer/models/workout_timers.dart';
import 'package:workouttimer/screens/add_edit_workout_timer.dart';
import 'package:workouttimer/widgets/workout_timer_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Timer'),
        actions: <Widget>[
          if (Platform.isIOS) IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddEditWorkoutTimer.routeName);
            },
          )
        ],
      ),
      body: Container(
        child: Consumer<WorkoutTimers>(
          builder: (context, workoutTimers, child) => workoutTimers
                  .items.isEmpty
              ? Center(child: const Text("Empty"))
              : ListView.builder(
                  itemCount: workoutTimers.items.length,
                  itemBuilder: (context, index) => ChangeNotifierProvider.value(
                    value: workoutTimers.items[index],
                    child: WorkoutTimerItem(),
                  ),
                ),
        ),
      ),
      floatingActionButton: Platform.isIOS ? null : Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 8.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AddEditWorkoutTimer.routeName);
          },
        ),
      ),
    );
  }
}
