class Habit {
  String title;
  String description;
  int reward;

  Habit({required this.title, required this.description, required this.reward});

  factory Habit.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': String title,
        'description': String description,
        'reward': int reward,
      } =>
        Habit(title: title, description: description, reward: reward),
      _ => throw const FormatException('Failed to load habit.'),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'reward': reward
    };
  }
}


