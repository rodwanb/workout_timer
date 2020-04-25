import 'package:flutter/material.dart';
import 'package:workouttimer/screens/add_edit_workout_timer.dart';
import 'package:workouttimer/screens/play_workout_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Workout Timer'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddEditWorkoutTimer.routeName);
              },
            )
          ],
        ),
        body: Container(
          child: false
              ? Center(child: const Text("Empty"))
              : ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('30:00'),
                            ),
                          ),
                        ),
                        title: Text('BBR - Week 1 & 2'),
                        subtitle: Text('HIIT'),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(PlayWorkoutScreen.routeName);
                        },
                      ),
                    ),
                  ),
                ),
        ));
  }
}
