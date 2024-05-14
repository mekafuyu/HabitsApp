import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Placeholder(
            fallbackHeight: 100,
            fallbackWidth: 100,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Tarefa"),
                Text("NOME"),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
