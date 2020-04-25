import 'package:flutter/material.dart';
import 'package:workouttimer/screens/add_edit_workout_timer.dart';
import 'package:workouttimer/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(),
        AddEditWorkoutTimer.routeName: (_) => AddEditWorkoutTimer(),
      },
    );
  }
}
