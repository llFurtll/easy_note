import 'dart:io';

import 'get_default_dir.dart';

Future<bool?> createDir(String subFolder) async {
  try {
    String? path = await getDefaultDir();
    Directory subDir = Directory("$path/$subFolder");

    bool exist = await subDir.exists();
    if (!exist) {
      await subDir.create();
    }

    return true;
  } catch (_) {
    return null;
  }
}