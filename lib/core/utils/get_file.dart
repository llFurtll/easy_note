import 'dart:io';

import 'get_default_dir.dart';

Future<Directory?> getDir(String subFolder) async {
  try {
    Directory dir = await getDefaultDir();
    Directory subDir = Directory("${dir.path}/$subFolder");

    bool exist = await subDir.exists();
    if (exist) {
      return subDir;
    }

    return null;
  } catch (_) {
    return null;
  }
}