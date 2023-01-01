import 'package:sqflite/sqflite.dart';

import 'utils.dart';

void storageCreate(Database db, int version) async {
  await createAllTables(db);
  await insertRegistros(db);
}