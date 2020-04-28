import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:workouttimer/models/workout_timer.dart';
import 'package:workouttimer/models/workout_timers.dart';
import 'package:workouttimer/screens/add_edit_workout_timer.dart';
import 'package:workouttimer/widgets/time_control_button.dart';
import '../extensions/duration_extensions.dart';

class PlayWorkoutScreen extends StatefulWidget {
  static const routeName = '/play-workout/{id}';

  @override
  _PlayWorkoutScreenState createState() => _PlayWorkoutScreenState();
}

class _PlayWorkoutScreenState extends State<PlayWorkoutScreen> {
  var _didInit = false;
  String workoutTimerId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_didInit) {
      return;
    }

    workoutTimerId = ModalRoute.of(context).settings.arguments as String;
    if (workoutTimerId == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final workoutTimer = Provider.of<WorkoutTimers>(context).findById(workoutTimerId);
    return ChangeNotifierProvider.value(
      value: workoutTimer,
      child: Consumer<WorkoutTimer>(
        builder: (context, timer, child) => Scaffold(
          appBar: AppBar(
            title: Text(
              timer.name,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AddEditWorkoutTimer.routeName,
                    arguments: timer.id,
                  );
                },
              )
            ],
          ),
          body: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.orangeAccent, Colors.deepOrange],
//                  ? [Colors.orangeAccent, Colors.deepOrange]
//                  : [Colors.green, Colors.lightGreenAccent],
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        timer.currentStep.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            color: Colors.black45),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: SizedBox(
                          height: 100,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              Duration(seconds: timer.remainingSeconds).asTimeString(),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: timer.isRunning
                      ? TimeControlButton.pause(timer.pause)
                      : TimeControlButton.play(timer.start),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
