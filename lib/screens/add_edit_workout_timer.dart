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
  var _editedWorkoutTimer = WorkoutTimer.standard();
  var _initValues = WorkoutTimer.standard();

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
        Provider.of<WorkoutTimers>(context, listen: false).findById(workoutTimerId);
    _initValues = _editedWorkoutTimer.copyWith();
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

  String _format(Duration duration) {
    return '${duration.inSeconds}';
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
              SizedBox(height: 16),
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
                  _editedWorkoutTimer = _editedWorkoutTimer.copyWith(name: value);
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: '${_initValues.countdownDuration.inSeconds}',
                decoration: InputDecoration(labelText: 'Countdown'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (value) {
                  print('onFieldSubmitted: $value');
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a countdown duration';
                  }
                  return null;
                },
                onSaved: (value) {
                  final parsedValue = int.tryParse(value) ?? 0;
                  _editedWorkoutTimer = _editedWorkoutTimer.copyWith(countdownDuration: Duration(seconds: parsedValue));
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _format(_initValues.warmUpDuration),
                decoration: InputDecoration(labelText: 'Warm-up'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (value) {
                  print('onFieldSubmitted: $value');
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a warm-up duration';
                  }
                  return null;
                },
                onSaved: (value) {
                  final parsedValue = int.tryParse(value) ?? 0;
                  _editedWorkoutTimer = _editedWorkoutTimer.copyWith(warmUpDuration: Duration(seconds: parsedValue));
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _format(_initValues.exerciseDuration),
                decoration: InputDecoration(labelText: 'Exercise'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (value) {
                  print('onFieldSubmitted: $value');
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide an exercise duration';
                  }
                  return null;
                },
                onSaved: (value) {
                  final parsedValue = int.tryParse(value) ?? 0;
                  _editedWorkoutTimer = _editedWorkoutTimer.copyWith(exerciseDuration: Duration(seconds: parsedValue));
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _format(_initValues.changeOverDuration),
                decoration: InputDecoration(labelText: 'Change-over'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (value) {
                  print('onFieldSubmitted: $value');
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a change-over duration';
                  }
                  return null;
                },
                onSaved: (value) {
                  final parsedValue = int.tryParse(value) ?? 0;
                  _editedWorkoutTimer = _editedWorkoutTimer.copyWith(changeOverDuration: Duration(seconds: parsedValue));
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _format(_initValues.restDuration),
                decoration: InputDecoration(labelText: 'Rest'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (value) {
                  print('onFieldSubmitted: $value');
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a rest duration';
                  }
                  return null;
                },
                onSaved: (value) {
                  final parsedValue = int.tryParse(value) ?? 0;
                  _editedWorkoutTimer = _editedWorkoutTimer.copyWith(restDuration: Duration(seconds: parsedValue));
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: '${_initValues.numberOfSets}',
                decoration: InputDecoration(labelText: 'Sets'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (value) {
                  print('onFieldSubmitted: $value');
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide number of sets';
                  }
                  return null;
                },
                onSaved: (value) {
                  final parsedValue = int.tryParse(value) ?? 0;
                  _editedWorkoutTimer = _editedWorkoutTimer.copyWith(numberOfSets: parsedValue);
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _format(_initValues.coolDownDuration),
                decoration: InputDecoration(labelText: 'Cool down'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (value) {
                  print('onFieldSubmitted: $value');
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a cool down duration';
                  }
                  return null;
                },
                onSaved: (value) {
                  final parsedValue = int.tryParse(value) ?? 0;
                  _editedWorkoutTimer = _editedWorkoutTimer.copyWith(coolDownDuration: Duration(seconds: parsedValue));
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: '${_initValues.numberOfRounds}',
                decoration: InputDecoration(labelText: 'Rounds'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (value) {
                  print('onFieldSubmitted: $value');
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide number of rounds';
                  }
                  return null;
                },
                onSaved: (value) {
                  final parsedValue = int.tryParse(value) ?? 0;
                  _editedWorkoutTimer = _editedWorkoutTimer.copyWith(numberOfRounds: parsedValue);
                },
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
