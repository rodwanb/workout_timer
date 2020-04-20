import 'package:flutter/material.dart';

class TimeControlButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;

  const TimeControlButton({this.onPressed, this.icon});

  const TimeControlButton.play(this.onPressed) : this.icon = Icons.play_arrow;

  const TimeControlButton.pause(this.onPressed) : this.icon = Icons.pause;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(
          icon,
          size: 58,
        ),
      ),
      onPressed: onPressed,
      shape: const CircleBorder(),
      elevation: 10,
    );
  }
}
