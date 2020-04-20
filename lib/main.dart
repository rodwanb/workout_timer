import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttimer/models/time.dart';
import 'package:workouttimer/screens/play_workout_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => Time(duration: 30),
        child: PlayWorkoutScreen(),
      ),
    );
  }
}
