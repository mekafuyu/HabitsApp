import 'package:flutter/material.dart';
import 'package:habitsapp/models/habit_provider.dart';
import 'package:habitsapp/screens/login_page.dart';
import 'package:habitsapp/screens/register_page.dart';
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
              seedColor: Colors.blue.shade900, brightness: Brightness.dark),
          useMaterial3: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home':(context) => HomePage(),
          },
        // home: const HomePage(title: 'Habits App'),
      ),
    );
  }
}

