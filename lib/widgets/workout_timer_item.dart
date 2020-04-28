import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttimer/models/workout_timer.dart';
import 'package:workouttimer/screens/play_workout_screen.dart';

class WorkoutTimerItem extends StatelessWidget {
  const WorkoutTimerItem();

  String _format(Duration duration) {
    String twoDigits(int n) => n >= 10 ? '$n' : '0$n';

    var minutes = twoDigits(duration.inMinutes.remainder(60));
    var seconds = twoDigits(duration.inSeconds.remainder(60));

    var hours = '';
    if (duration.inHours > 0) {
      hours = '${twoDigits(duration.inHours)}:';
    }
    return '$hours$minutes:$seconds';
  }


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
                  child: Text(_format(workoutTimer.totalDuration)),
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
