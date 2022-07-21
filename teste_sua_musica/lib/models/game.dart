class Game {
  final int id;
  final String name;
  final String? summary;

  Game({
    required this.id,
    required this.name,
    this.summary,
  });

  Game.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        summary = json['summary'];
}
