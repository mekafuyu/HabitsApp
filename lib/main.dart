import 'package:flutter/material.dart';
import 'package:habitsapp/habits/habit.dart';
import 'package:provider/provider.dart';

import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HabitProvider(),
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

class HabitProvider extends ChangeNotifier {
  var habits = <Habit> [];
  late Future<Habit> futureHabit;

  void addTask(Habit h)
  {
    
  }

  void removeTask(Habit h)
  {

  }

  HabitProvider() {
    fetchHabits();
  }

  void fetchHabits() {
    futureHabit = fetchHabit();
    notifyListeners();
  }



}