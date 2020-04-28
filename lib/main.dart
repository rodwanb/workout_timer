import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttimer/models/workout_timer.dart';
import 'package:workouttimer/models/workout_timers.dart';
import 'package:workouttimer/screens/add_edit_workout_timer.dart';
import 'package:workouttimer/screens/home_screen.dart';
import 'package:workouttimer/screens/play_workout_screen.dart';

import 'models/time.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WorkoutTimers([
            WorkoutTimer.standard().copyWith(
              id: UniqueKey().toString(),
              name: 'Test Workout',
            )
          ]),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => HomeScreen(),
          AddEditWorkoutTimer.routeName: (_) => AddEditWorkoutTimer(),
          PlayWorkoutScreen.routeName: (_) => PlayWorkoutScreen(),
        },
      ),
    );
  }
}
