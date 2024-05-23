import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:habitsapp/habits/habit.dart';
import 'package:habitsapp/habits/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HabitProvider extends ChangeNotifier {
  late Future<List<Habit>> futureHabits;
  late Future<User> futureUser;
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
      saveTasksLocally(user!.nick);
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

  Future<bool> removeTask(Habit h) async {
    bool removed = false;

    if (useLocally) {
      habits.remove(h);
      notifyListeners();
      saveTasksLocally(user!.nick);
      return true;
    }

    var taskId = Uri.encodeComponent(h.id.toString());
    var jwtUri = Uri.encodeComponent(_jwt!);
    var res = await http.post(
      Uri.parse('http://localhost:5140/task/disable?id=$taskId&token=$jwtUri'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
      }),
    );
    debugPrint(res.statusCode.toString());
    if (res.statusCode == 200) {
      removed = true;
      fetchTasks();
    }
    return removed;
  }

  Future<bool> updateTask(Habit h, String title, String description, int reward) async{
    bool updated = false;
    if (useLocally) {
      h.title = title;
      h.description = description;
      h.reward = reward;
      notifyListeners();
      saveTasksLocally(user!.nick);
      return true;
    }

    var taskId = Uri.encodeComponent(h.id.toString());
    var res = await http.put(
      Uri.parse('http://localhost:5140/task?id=$taskId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'token': _jwt,
        'title': title,
        'description': description,
        'reward': reward,
      }),
    );
    if (res.statusCode == 200) {
      updated = true;
      fetchTasks();
    }
    return updated;
  }

  Future<void> completeTask(Habit h) async {
    if (useLocally) {
      removeTask(h);
      user?.money += h.reward;
      saveTasksLocally(user!.nick);
      saveUserLocally(user!.nick);
      notifyListeners();
      return;
    }
    
    var taskId = Uri.encodeComponent(h.id.toString());
    var jwtUri = Uri.encodeComponent(_jwt!);
    var res = await http.post(
      Uri.parse('http://localhost:5140/task/complete?id=$taskId&token=$jwtUri'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
      }),
    );
    if (res.statusCode == 200) {
      fetchTasks();
    }
  }

  Future<void> restoreLocalTasks(String username) async {
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

  void saveTasksLocally(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("tasks-$username", jsonEncode(habits));
  }

  void saveUserLocally(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user-$username", jsonEncode(user));
  }

  void fetchTasks() async {
    futureHabits = _fetchTasks(_jwt);
    futureUser = _fetchUser(_jwt);
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
      debugPrint(jsonList.toString());
      List<Habit> habits =
          jsonList.map((json) => Habit.fromJson(json)).toList();
      return habits;
    } else {
      return <Habit>[];
    }
  }

  Future<User> _fetchUser(jwt) async {
    if (jwt == null || jwt == "") {
      return User(nick: "user");
    }

    final response = await http.get(
      Uri.parse('http://localhost:5140/user?token=${Uri.encodeComponent(jwt)}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var jsonUser = jsonDecode(response.body);
      User user = User.fromJson(jsonUser);
      return user;
    } else {
      return User(nick: "user");
    }
  }

  HabitProvider() {
    fetchTasks();
  }
}
