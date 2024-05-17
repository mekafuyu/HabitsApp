import 'package:flutter/material.dart';
import 'package:habitsapp/habits/habit.dart';
import 'package:habitsapp/main.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatelessWidget {
  final Habit habit;
  const TaskCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(habit.name, style: const TextStyle(fontFamily: "Righteous", fontSize: 24),),
                      Text(habit.description, style: const TextStyle(fontFamily: "Righteous", fontSize: 18),),
                    ],
                  ),
                ),
                Column(
                  children: [
                    // FIXME

                    ElevatedButton(
                      onPressed: () {},                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSurface,
                        minimumSize: const Size(5, 5),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(Icons.check),
                    ),
                    const SizedBox(height: 5,),
                    ElevatedButton(
                      onPressed: () { appState.removeTask(habit); },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor:
                              Theme.of(context).colorScheme.onSurface,
                          minimumSize: const Size(5, 5),
                          padding: EdgeInsets.zero
                        ),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
