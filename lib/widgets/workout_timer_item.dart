import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttimer/models/workout_timer.dart';
import 'package:workouttimer/screens/add_edit_workout_timer.dart';

class WorkoutTimerItem extends StatelessWidget {
  const WorkoutTimerItem();

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutTimer>(
      builder: (context, workoutTimer, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
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
//            Navigator.of(context)
//                .pushNamed(PlayWorkoutScreen.routeName);
              Navigator.of(context).pushNamed(
                AddEditWorkoutTimer.routeName,
                arguments: workoutTimer.id,
              );
            },
          ),
        ),
      ),
    );
  }
}
