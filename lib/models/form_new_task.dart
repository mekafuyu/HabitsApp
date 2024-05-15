import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habitsapp/habits/habit.dart';
import 'package:habitsapp/main.dart';
import 'package:provider/provider.dart';

class FormNewTask extends StatefulWidget {
  const FormNewTask({super.key});

  @override
  State<FormNewTask> createState() => _FormNewTaskState();
}

class _FormNewTaskState extends State<FormNewTask> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: "TaskName",
                decoration: const InputDecoration(labelText: 'Task Name:'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (val) {
                  debugPrint(val);
                },
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: "TaskDescription",
                decoration:
                    const InputDecoration(labelText: 'Task Description:'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (val) {
                  debugPrint(val);
                },
              ),
              MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  // Validate and save the form values
                  _formKey.currentState?.saveAndValidate();
                  var formData = _formKey.currentState?.value;
                  appState.addTask(Habit(name: formData?["TaskName"], description: formData?["TaskDescription"]));
                },
                child: const Text('Login'),
              )
            ],
          ),
        ));
  }
}
