import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitsapp/habits/user.dart';

import 'coin_viewer.dart';

class UserCard extends StatelessWidget {
  final User? user;
  const UserCard({super.key, required this.user});

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
              const Text("Welcome Back,", textAlign: TextAlign.center, style: TextStyle(fontFamily: "Righteous", fontSize: 18),),
              Text("Adventurer ${user?.nick ?? "USER"}", textAlign: TextAlign.center, style: const TextStyle(fontFamily: "Righteous", fontSize: 26),),
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
                    value: (user?.life ?? 1.0) / (user?.maxLife ?? 1.0)
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
                    value: 1
                  ),)
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  CoinViewer(value: (user?.money ?? 10101) ~/ 10000, color: Colors.amber),
                  const SizedBox(width: 10),
                  CoinViewer(value: (user?.money ?? 10101) % 10000 ~/ 100, color: Colors.white70),
                  const SizedBox(width: 10),
                  CoinViewer(value: (user?.money ?? 10101) % 100, color: Colors.deepOrange),
                ],
              )
            ],
          ),
        ))
      ]),
    );
  }
}
