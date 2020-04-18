import 'dart:async';

import 'package:flutter/material.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer _timer;
  var _duration = 30;

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print('tick: $_duration');
      setState(() {
        if (_duration <= 0) {
          _duration = 30;
        } else {
          _duration--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // in the middle of the parent.
        child: Stack(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Opacity(
                  opacity: _duration <= 30 ? 1.0 : 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Opacity(
                  opacity: _duration <= 20 ? 1.0 : 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Opacity(
                  opacity: _duration <= 10 ? 1.0 : 0.3,
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
            child: Text(
              '$_duration',
              style: TextStyle(fontSize: 48),
            ),
          )
        ]),
      ),
    );
  }
}
