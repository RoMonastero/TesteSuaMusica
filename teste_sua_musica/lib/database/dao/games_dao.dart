import 'package:sqflite/sqflite.dart';
import 'package:teste_sua_musica/models/game.dart';

import '../app_database.dart';

class GamesDao {
  static const tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_summary TEXT, '
      '$_plataforms TEXT, '
      '$_genres TEXT)';

  static const String _tableName = 'games';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _summary = 'summary';
  static const String _plataforms = 'plataforms';
  static const String _genres = 'genres';

  Future save(Game game) async {
    final Database db = await creatDatabase();
    final Map<String, dynamic> gamesMap = toMap(game);

    List<Map<String, Object?>> gamesList =
        await db.query('games', columns: ['id'], where: 'id = ${game.id}');

    if (gamesList.isEmpty) {
      return await db.insert(_tableName, gamesMap);
    }
  }

  Map<String, dynamic> toMap(Game game) {
    return <String, dynamic>{
      _id: game.id,
      _name: game.name,
      _summary: game.summary,
      _plataforms: game.plataforms.toString(),
      _genres: game.genres.toString(),
    };
  }

  Future<List<Game>> findAll() async {
    final Database db = await creatDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    final List<Game> games = toList(maps);
    return games;
  }

  List<Game> toList(List<Map<String, dynamic>> maps) {
    final List<Game> games = [];
    for (Map<String, dynamic> map in maps) {
      final Game game = Game(
        name: map[_name],
        id: map[_id],
        summary: map[_summary],
        plataforms: stringtoList(map[_plataforms].toString()),
        genres: stringtoList(map[_genres].toString()),
      );

      games.add(game);
    }

    return games;
  }

  List stringtoList(String item) {
    item = item.substring(1, item.length - 1).trim();

    List items = item.split(',');

    for (var i = 0; i < items.length; i++) {
      items[i] = items[i].trim();
    }

    return items;
  }
}
