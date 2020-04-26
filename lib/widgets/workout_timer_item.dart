import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttimer/models/workout_timer.dart';
import 'package:workouttimer/screens/play_workout_screen.dart';

class WorkoutTimerItem extends StatelessWidget {
  const WorkoutTimerItem();

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutTimer>(
      builder: (context, workoutTimer, child) => Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('30:00'),
                ),
              ),
            ),
            title: Text(workoutTimer.name),
            subtitle: Text('HIIT'),
            onTap: () {
              Navigator.of(context).pushNamed(
                PlayWorkoutScreen.routeName,
                arguments: workoutTimer.id,
              );
            },
          ),
        ),
      ),
    );
  }
}
