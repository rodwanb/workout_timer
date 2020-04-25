import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:workouttimer/models/time.dart';
import 'package:workouttimer/widgets/time_control_button.dart';

class PlayWorkoutScreen extends StatelessWidget {
  static const routeName = '/play-workout/{id}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildAnimatedController(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildTimeModeLabel(),
                  _buildTimeLabel(),
                ],
              ),
            ),
            _buildTimeControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    var time = Provider.of<Time>(context);
    return AppBar(
        backgroundColor:
            time.mode == TimeMode.work ? Colors.orangeAccent : Colors.green,
        title: const Text(
          'Workout Timer',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit,
            ),
            color: Colors.black45,
            onPressed: () {},
          )
        ],
    );
  }

  Widget _buildAnimatedController({Widget child}) {
    return Consumer<Time>(
      builder: (context, time, ch) => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: time.mode == TimeMode.work
                  ? [Colors.orangeAccent, Colors.deepOrange]
                  : [Colors.green, Colors.lightGreenAccent],
            ),
          ),
          child: ch),
      child: child,
    );
  }

  Widget _buildTimeLabel() {
    String format(Duration duration) {
      String twoDigits(int n) => n >= 10 ? '$n' : '0$n';

      var minutes = twoDigits(duration.inMinutes.remainder(60));
      var seconds = twoDigits(duration.inSeconds.remainder(60));

      var hours = '';
      if (duration.inHours > 0) {
        hours = '${twoDigits(duration.inHours)}:';
      }
      return '$hours$minutes:$seconds';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Consumer<Time>(
          builder: (context, time, child) => Text(
            format(Duration(seconds: time.ticker)),
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
    );
  }

  Widget _buildTimeModeLabel() {
    return Consumer<Time>(
      builder: (context, time, child) => Text(
        time.mode == TimeMode.work ? 'Work' : 'Rest',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
            color: Colors.black45),
      ),
    );
  }

  Widget _buildTimeControls() {
    return Consumer<Time>(
      builder: (context, time, child) => Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: time.isRunning
            ? TimeControlButton.pause(time.pause)
            : TimeControlButton.play(time.start),
      ),
    );
  }
}
