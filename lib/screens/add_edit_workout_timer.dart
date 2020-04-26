import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttimer/models/workout_timer.dart';
import 'package:workouttimer/models/workout_timers.dart';

class AddEditWorkoutTimer extends StatefulWidget {
  static const routeName = '/add-edit-workout-timer';

  @override
  _AddEditWorkoutTimerState createState() => _AddEditWorkoutTimerState();
}

class _AddEditWorkoutTimerState extends State<AddEditWorkoutTimer> {
  final _form = GlobalKey<FormState>();
  var _didInit = false;
  var _editedWorkoutTimer = WorkoutTimer();
  var _initValues = WorkoutTimer();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didInit) {
      return;
    }
    _didInit = true;

    final workoutTimerId = ModalRoute.of(context).settings.arguments as String;
    if (workoutTimerId == null) {
      return;
    }

    _editedWorkoutTimer =
        Provider.of<WorkoutTimers>(context).findById(workoutTimerId);
    _initValues = _editedWorkoutTimer.copy();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedWorkoutTimer.id == null) {
      //add
      Provider.of<WorkoutTimers>(context, listen: false).add(
        _editedWorkoutTimer,
      );
    } else {
      Provider.of<WorkoutTimers>(context, listen: false).update(
        _editedWorkoutTimer.id,
        _editedWorkoutTimer,
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Workout Timer"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues.name,
                decoration: InputDecoration(labelText: 'Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  print('onFieldSubmitted: $value');
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedWorkoutTimer = _editedWorkoutTimer.copy(name: value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
