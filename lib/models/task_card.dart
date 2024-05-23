import 'package:flutter/material.dart';
import 'package:habitsapp/habits/habit.dart';
import 'package:habitsapp/models/coin_viewer.dart';
import 'package:habitsapp/models/habit_provider.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatelessWidget {
  final Habit habit;
  final Function openModal;
  const TaskCard({super.key, required this.habit, required this.openModal});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<HabitProvider>();
    debugPrint(kMinInteractiveDimension.toString());
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
                      Text(
                        habit.title,
                        style: const TextStyle(
                            fontFamily: "Righteous", fontSize: 24),
                      ),
                      Text(
                        habit.description,
                        style: const TextStyle(
                            fontFamily: "Righteous", fontSize: 18),
                      ),
                      Row(
                        children: [
                          CoinViewer(
                              value: habit.reward ~/ 10000,
                              color: Colors.amber),
                          const SizedBox(width: 10),
                          CoinViewer(
                              value: habit.reward % 10000 ~/ 100,
                              color: Colors.white70),
                          const SizedBox(width: 10),
                          CoinViewer(
                              value: habit.reward % 100,
                              color: Colors.deepOrange),
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.black87),
                      icon: const Icon(Icons.check_rounded),
                    ),
                    IconButton(
                      onPressed: () => openModal(context, habit),
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black87),
                      icon: const Icon(Icons.settings_outlined),
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
