class Habit {
  int id;
  String title;
  String description;
  int reward;
  bool enable;

  Habit({required this.id, required this.title, required this.description, required this.reward, required this.enable});

  factory Habit.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
        'description': String description,
        'reward': int reward,
        'enable': bool enable
      } =>
        Habit(id: id, title: title, description: description, reward: reward, enable: enable),
      _ => throw const FormatException('Failed to load habit.'),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'reward': reward,
      'enable': enable
    };
  }
}


