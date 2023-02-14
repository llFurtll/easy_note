import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'storage_create.dart';
import 'storage_update.dart';

abstract class Storage<T> {
  Future<void> initStorage();
  Future<T> getStorage();
}

class StorageImpl extends Storage<Database> {
  @override
  Future<void> initStorage() async {
    await openDatabase(
      join(await getDatabasesPath(), "note.db"),
      version: 4,
      onCreate: storageCreate,
      onUpgrade: storageUpdate
    );
  }

  @override
  Future<Database> getStorage() async {
    return await openDatabase(join(await getDatabasesPath(), "note.db"));
  }
}