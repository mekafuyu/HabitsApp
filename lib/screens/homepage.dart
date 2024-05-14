import 'package:flutter/material.dart';
import 'package:habitsapp/main.dart';
import 'package:habitsapp/models/taskcard.dart';
import 'package:habitsapp/models/usercard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [UserCard(), TaskCard()]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
