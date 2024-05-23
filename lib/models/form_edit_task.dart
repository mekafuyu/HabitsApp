import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habitsapp/habits/habit.dart';
import 'package:habitsapp/models/habit_provider.dart';
import 'package:provider/provider.dart';

class FormEditTask extends StatefulWidget {
  final Habit habit;
  const FormEditTask({super.key, required this.habit});

  @override
  State<FormEditTask> createState() => _FormEditTaskState();
}

class _FormEditTaskState extends State<FormEditTask> {
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
                initialValue: widget.habit.title,
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
                initialValue: widget.habit.description,
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
                initialValue: widget.habit.reward.toString(),
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
                        appState.removeTask(widget.habit);
                        Navigator.pop(context);
                      },
                      child: const Text('Remove Task'),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      var isValid = _formKey.currentState?.saveAndValidate();
                      var formData = _formKey.currentState?.value;
                      if(isValid!) {
                        appState.
                        updateTask(widget.habit,
                          formData?["TaskName"],
                          formData?["TaskDescription"],
                          int.parse(formData?["TaskReward"])
                        ).then((value) {
                          debugPrint(value.toString());
                          if(value) {
                            Navigator.pop(context);
                          }
                        });
                      }
                    },
                    child: const Text('Update Task'),
                  ),
                ],
              )
            ],
          ),
        );
  }
}
