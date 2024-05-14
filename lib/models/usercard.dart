import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Row(children: [
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
            children: [
              Placeholder(
                fallbackHeight: 100,
              )
              // Text("Bem Vindo Aventureiro"),
              // Text("NOME"),
            ],
          ),
        ))
      ]),
    );
  }
}
