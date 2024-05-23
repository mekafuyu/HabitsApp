import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habitsapp/habits/habit.dart';
import 'package:habitsapp/models/habit_provider.dart';
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
    var appState = context.watch<HabitProvider>();

    return FormBuilder(
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
                  if (value.length > 20) {
                    return 'Task name too long';
                  }

                  return null;
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
              ),
              FormBuilderTextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                name: "TaskReward",
                decoration:
                    const InputDecoration(labelText: 'Task Reward:'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var isValid = _formKey.currentState?.saveAndValidate();
                      var formData = _formKey.currentState?.value;
                      if(isValid!) {
                        appState.
                        addTask(Habit(
                          id: appState.habits.length,
                          title: formData?["TaskName"],
                          description: formData?["TaskDescription"],
                          reward: int.parse(formData?["TaskReward"],),
                          enable: true
                        )).then((value) {
                          debugPrint(value.toString());
                          if(value) {
                            Navigator.pop(context);
                          }
                        });
                      }
                    },
                    child: const Text('Add Task'),
                  ),
                ],
              )
            ],
          ),
        );
  }
}
