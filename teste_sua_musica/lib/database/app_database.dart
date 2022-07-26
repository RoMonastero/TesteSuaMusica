import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/games_dao.dart';
import 'dao/genre_dao.dart';
import 'dao/plataforms_dao.dart';

Future<Database> creatDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'games.db');
  return await openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(PlataformDao.tableSql);
      await db.execute(GamesDao.tableSql);
      await db.execute(GenreDao.tableSql);
    },
    version: 1,
  );
}
