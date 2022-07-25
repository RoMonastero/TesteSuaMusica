class Game {
  final int id;
  final String name;
  final String summary;
  final List plataforms;
  final List genres;

  Game({
    required this.id,
    required this.name,
    required this.plataforms,
    required this.summary,
    required this.genres,
  });

  Game.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        plataforms = json['platforms'] ?? [],
        genres = json['genres'] ?? [],
        summary = json['summary'] ?? '';

  String plataformsIdToString() {
    String plataformsString = '';
    for (var plataform in plataforms) {
      plataformsString += '$plataform,';
    }

    return plataformsString.substring(0, plataformsString.length - 1);
  }

  String genresIdToString() {
    String genresString = '';
    for (var genre in genres) {
      genresString += '$genre,';
    }

    return genresString.substring(0, genresString.length - 1);
  }
}
