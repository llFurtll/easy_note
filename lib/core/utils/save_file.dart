import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'create_dir.dart';

Future<String> saveFile(String pathFile, String folder) async {
  try {
    final storage = await createDir(folder);

    if (storage.isEmpty) {
      return "";
    }

    String ext = extension(pathFile);
    String nameFile = "${UniqueKey().hashCode}$ext";

    File fileCache = File(pathFile);
    File file = fileCache.copySync("$storage/$nameFile");

    return file.path;
  } catch (_) {
    return "";
  }
}