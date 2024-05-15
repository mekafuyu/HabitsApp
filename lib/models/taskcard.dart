import 'package:flutter/material.dart';
import 'package:habitsapp/habits/habit.dart';

class TaskCard extends StatelessWidget {
  final Habit habit;
  const TaskCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Placeholder(
            fallbackHeight: 100,
            fallbackWidth: 100,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(habit.name),
                Text(habit.description),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
