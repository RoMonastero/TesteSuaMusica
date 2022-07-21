import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/plataforms_dao.dart';

Future<Database> creatPlataformDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'plataforms.db');
  return await openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(PlataformDao.tableSql);
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
