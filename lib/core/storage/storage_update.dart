import 'package:sqflite/sqflite.dart';

import 'utils.dart';

void storageUpdate(Database db, int version, int newVersion) async {
  loadConfigs();
  await createAllTables(db);
  await insertRegistros(db);
  await updateTables(db);
}