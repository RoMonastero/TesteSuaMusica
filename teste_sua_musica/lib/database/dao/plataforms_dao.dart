import 'package:sqflite/sqflite.dart';

import '../../models/plataform.dart';
import '../app_database.dart';

class PlataformDao {
  static const tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT)';

  static const String _tableName = 'plataforms';
  static const String _id = 'id';
  static const String _name = 'name';

  save(Plataform plataform) async {
    final Database db = await creatPlataformDatabase();
    final Map<String, dynamic> plataformMap = toMap(plataform);

    List<Map<String, Object?>> plataformsList = await db.query('plataforms',
        columns: ['id'], where: 'id = ${plataform.id}');

    if (plataformsList.isEmpty) {
      return await db.insert(_tableName, plataformMap);
    }
  }

  Map<String, dynamic> toMap(Plataform plataform) {
    return <String, dynamic>{
      _id: plataform.id,
      _name: plataform.name,
    };
  }

  Future<List<Plataform>> findAll() async {
    final Database db = await creatPlataformDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    final List<Plataform> contacts = toList(maps);
    return contacts;
  }

  List<Plataform> toList(List<Map<String, dynamic>> maps) {
    final List<Plataform> plataforms = [];
    for (Map<String, dynamic> map in maps) {
      final Plataform plataform = Plataform(
        name: map[_name],
        id: map[_id],
      );

      plataforms.add(plataform);
    }

    return plataforms;
  }
}
