import 'package:flutter/material.dart';
import 'package:habitsapp/habits/habit.dart';
import 'package:provider/provider.dart';

import 'screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'HabitsApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: const HomePage(title: 'Habits App'),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var habits = <Habit> [];

  void addTask(Habit h) {
    habits.add(h);
    notifyListeners();
  }
}