class Game {
  final int id;
  final String name;
  final String summary;
  final List platforms;

  Game({
    required this.id,
    required this.name,
    required this.platforms,
    required this.summary,
  });

  Game.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        platforms = json['platforms'] ?? [],
        summary = json['summary'] ?? '';
}
