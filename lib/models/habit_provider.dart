import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:habitsapp/habits/habit.dart';
import 'package:habitsapp/habits/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HabitProvider extends ChangeNotifier {
  late Future<List<Habit>> futureHabits;
  List<Habit> habits = [];
  User? user;
  bool useLocally = false;
  String? _jwt;
  String? nick;

  void setJwt(String jwt) async {
    _jwt = jwt;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt', jwt);
  }

  String? getJwt() {
    return _jwt;
  }

  void logout() async {
    _jwt = null;
    nick = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
  }

  Future<bool> addTask(Habit h) async {
    bool added = false;
    if (useLocally) {
      habits.add(h);
      notifyListeners();
      saveTasksLocally(user?.nick);
      return true;
    }

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
      fetchTasks();
    }
    return added;
  }

  void removeTask(Habit h) {
    if (useLocally) {
      habits.remove(h);
      notifyListeners();
      saveTasksLocally(user?.nick);
      return;
    }
  }

  Future<bool> updateTask(Habit h, String title, String description, int reward) async{
    bool updated = false;
    if (useLocally) {
      h.title = title;
      h.description = description;
      h.reward = reward;
      notifyListeners();
      saveTasksLocally(user?.nick);
      return true;
    }

    return updated;
  }


  Future<void> restoreLocalTasks(username) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTasks = prefs.getString('tasks-$username');
    if (jsonTasks == null || jsonTasks == "") {
      habits = <Habit>[];
      saveTasksLocally(username);
      return;
    }
    List<dynamic> jsonList = jsonDecode(jsonTasks);
    habits = jsonList.map((json) => Habit.fromJson(json)).toList();
  }

  Future<void> restoreLocalUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final userjson = prefs.getString('user-$username');
    if (userjson == null || userjson == "") {
      user = User(nick: username);
      saveUserLocally(username);
      return;
    }
    user = User.fromJson(jsonDecode(userjson));
  }

  void saveTasksLocally(username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("tasks-$username", jsonEncode(habits));
  }

  void saveUserLocally(username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user-$username", jsonEncode(user));
  }

  void fetchTasks() async {
    futureHabits = _fetchTasks(_jwt);
    notifyListeners();
  }

  Future<List<Habit>> _fetchTasks(jwt) async {
    if (jwt == null || jwt == "") {
      return <Habit>[];
    }

    final response = await http.get(
      Uri.parse('http://localhost:5140/task?token=${Uri.encodeComponent(jwt)}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Habit> habits =
          jsonList.map((json) => Habit.fromJson(json)).toList();
      return habits;
    } else {
      return <Habit>[];
    }
  }

  HabitProvider() {
    fetchTasks();
  }
}
