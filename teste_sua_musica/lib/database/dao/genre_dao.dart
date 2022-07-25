import 'package:sqflite/sqflite.dart';
import 'package:teste_sua_musica/models/genre.dart';

import '../app_database.dart';

class GenreDao {
  static const tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT)';

  static const String _tableName = 'genres';
  static const String _id = 'id';
  static const String _name = 'name';

  Future save(Genre genre) async {
    final Database db = await creatDatabase();
    final Map<String, dynamic> genreMap = toMap(genre);

    List<Map<String, Object?>> genresList =
        await db.query('genres', columns: ['id'], where: 'id = ${genre.id}');

    if (genresList.isEmpty) {
      return await db.insert(_tableName, genreMap);
    }
  }

  Map<String, dynamic> toMap(Genre genre) {
    return <String, dynamic>{
      _id: genre.id,
      _name: genre.name,
    };
  }

  Future<List<Genre>> findAll() async {
    final Database db = await creatDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    final List<Genre> genres = toList(maps);
    return genres;
  }

  List<Genre> toList(List<Map<String, dynamic>> maps) {
    final List<Genre> genres = [];
    for (Map<String, dynamic> map in maps) {
      final Genre genre = Genre(
        name: map[_name],
        id: map[_id],
      );

      genres.add(genre);
    }

    return genres;
  }
}
