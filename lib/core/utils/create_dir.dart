import 'dart:io';

import 'get_default_dir.dart';

Future<String> createDir(String subFolder) async {
  try {
    Directory dir = await getDefaultDir();
    Directory subDir = Directory("${dir.path}/$subFolder");

    bool exist = await subDir.exists();
    if (!exist) {
      await subDir.create(recursive: true);
    }

    return subDir.path;
  } catch (_) {
    return "";
  }
}