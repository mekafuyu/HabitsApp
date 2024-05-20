import 'dart:convert';

import 'package:http/http.dart' as http;

class Habit {
  final String name;
  final String description;

  Habit({required this.name, required this.description});

  factory Habit.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'logradouro': String logradouro,
        'bairro': String bairro,
        'localidade': String localidade,
      } =>
        Habit(
          name: logradouro,
          description: "$bairro $localidade",
        ),
      _ => throw const FormatException('Failed to load habit.'),
    };
  }
}

Future<Habit> fetchHabit() async {
  final response = await http
      .get(Uri.parse('https://viacep.com.br/ws/81720290/json/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Habit.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}