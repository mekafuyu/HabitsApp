import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:habitsapp/habits/habit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HabitProvider extends ChangeNotifier {
  late Future<List<Habit>> futureHabits;
  String? _jwt;
  String? nick;

  void setJwt(String jwt) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt', jwt);
    _jwt = jwt;
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
    _jwt = null;
    nick = null;
  }

  String? getJwt() {
    return _jwt;
  }

  Future<bool> addTask(Habit h) async {
    bool added = false;
    var res = await http.post(
      Uri.parse('http://localhost:5140/task'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "token": _jwt,
        "title": h.title,
        "description": h.description,
        "reward": h.reward
      }),
    );
    if (res.statusCode == 200) {
      added = true;
      getTasks();
    }
    return added;
  }

  void getTasks() async {
    futureHabits = fetchHabits(_jwt);
    notifyListeners();
  }

  void removeTask(Habit h) {}

  HabitProvider() {
    getTasks();
  }

}
