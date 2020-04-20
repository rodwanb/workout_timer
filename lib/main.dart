import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttimer/models/time.dart';

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
        create: (_) => Time(duration: 30),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orangeAccent, Colors.deepOrange],
          ),
        ),
        child: Consumer<Time>(
          builder: (context, time, child) => Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Work',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic, color: Colors.black45),
                    ),
                    Text(
                      '0:${time.ticker}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.black45),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: RaisedButton(
                  child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Icon(
                          time.isRunning ? Icons.pause : Icons.play_arrow,
                          size: 52)),
                  onPressed: time.isRunning ? time.pause : time.start,
                  shape: CircleBorder(),
                  elevation: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
