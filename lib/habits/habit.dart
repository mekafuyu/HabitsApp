import 'dart:convert';
import 'package:http/http.dart' as http;

class Habit {
  final String title;
  final String description;
  final int reward;

  Habit({required this.title, required this.description, required this.reward});

  factory Habit.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': String title,
        'description': String description,
        'reward': int reward,
      } =>
        Habit(
          title: title,
          description: description,
          reward: reward
        ),
      _ => throw const FormatException('Failed to load habit.'),
    };
  }
}

Future<List<Habit>> fetchHabits(jwt) async {
  final response = await http.get(
      Uri.parse('http://localhost:5140/task?token=$jwt'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> jsonList = jsonDecode(response.body);
    List<Habit> habits = jsonList.map((json) => Habit.fromJson(json)).toList();
    return habits;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    // throw Exception('Failed to load habits');
    return <Habit>[];
  }
}