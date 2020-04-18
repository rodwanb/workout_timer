import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttimer/models/workout_timer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => WorkoutTimer(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WorkoutTimer>(
        builder: (context, workoutTimer, child) => Center(
          // in the middle of the parent.
          child: Stack(children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Opacity(
                    opacity: workoutTimer.ticker <= 30 ? 1.0 : 0.3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Opacity(
                    opacity: workoutTimer.ticker <= 20 ? 1.0 : 0.3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Opacity(
                    opacity: workoutTimer.ticker <= 10 ? 1.0 : 0.3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: RaisedButton(
                child: Text(
                  '${workoutTimer.ticker}',
                  style: TextStyle(fontSize: 48),
                ),
                onPressed:  workoutTimer.isRunning ? workoutTimer.stopTimer : workoutTimer.startTimer,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
