class User {
  String nick;
  late int life;
  late int maxLife;
  late int stamine;
  late int money;

  User({required this.nick})
  {
    life = 100;
    maxLife = 100;
    stamine = 100;
    money = 0;
  }

  User.allParams({required this.nick,
  required this.life,
  required this.maxLife,
  required this.stamine,
  required this.money
});

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'nick': String nick,
        'life': int life,
        'maxLife': int maxLife,
        'stamine': int stamine,
        'money': int money,
      } =>
        User.allParams(
          nick: nick,
          life: life,
          maxLife: maxLife,
          stamine: stamine,
          money: money,
        ),
      _ => throw const FormatException('Failed to load habit.'),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'nick': nick,
      'life': life,
      'maxLife': maxLife,
      'stamine': stamine,
      'money': money,
    };
  }
}


