import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Placeholder(
            fallbackHeight: 120,
            fallbackWidth: 120,
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Welcome Back,", style: TextStyle(fontFamily: "Righteous", fontSize: 20),),
              Text("Adventurer USER", style: TextStyle(fontFamily: "Righteous", fontSize: 24),),
              Row(
                children: [
                  Icon(CupertinoIcons.heart_fill, color: Colors.red,),
                  // Icon(Icons)
                ],
              )
            ],
          ),
        ))
      ]),
    );
  }
}
