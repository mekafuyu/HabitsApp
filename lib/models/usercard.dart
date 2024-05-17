import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Placeholder(
            fallbackHeight: 120,
            fallbackWidth: 120,
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("Welcome Back,", style: TextStyle(fontFamily: "Righteous", fontSize: 18),),
              const Text("Adventurer User", style: TextStyle(fontFamily: "Righteous", fontSize: 26),),
              Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 16,
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: LinearProgressIndicator(
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                    backgroundColor: Colors.red.withOpacity(0.3),
                    value: 0.5
                  ),)
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  const Icon(
                    Icons.fitness_center,
                    color: Colors.cyanAccent,
                    size: 16,
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: LinearProgressIndicator(
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.cyanAccent,
                    backgroundColor: Colors.cyanAccent.withOpacity(0.3),
                    value: 0.5
                  ),)
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.money_dollar_circle_fill,
                    color: Colors.amber,
                    size: 16,
                  ),
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.only(left: 10),
                      color: Colors.amber.withOpacity(0.3),
                      child: const Text(
                        "1",
                        style: TextStyle(fontFamily: "Righteous", fontSize: 12),
                        textAlign: TextAlign.center,),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    CupertinoIcons.money_dollar_circle_fill,
                    color: Colors.white70,
                    size: 16,
                  ),
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.only(left: 10),
                      color: Colors.white70.withOpacity(0.3),
                      child: const Text(
                        "1",
                        style: TextStyle(fontFamily: "Righteous", fontSize: 12),
                        textAlign: TextAlign.center,),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    CupertinoIcons.money_dollar_circle_fill,
                    color: Colors.deepOrange,
                    size: 16,
                  ),
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.only(left: 10),
                      color: Colors.deepOrange.withOpacity(0.3),
                      child: const Text(
                        "1",
                        style: TextStyle(fontFamily: "Righteous", fontSize: 12),
                        textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              )
            ],
          ),
        ))
      ]),
    );
  }
}
