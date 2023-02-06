import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> saveFile(String pathFile, String folder) async {
  String pathBase = (await getApplicationDocumentsDirectory()).path;
  Directory pathFinal = Directory("$pathBase/$folder");
  final ext = extension(pathFile);

  final nameFile = "${UniqueKey().hashCode}$ext";

  try {
    if (!pathFinal.existsSync()) {
      pathFinal.createSync(recursive: true);
    }

    File cacheFile = File(pathFile);
    return await cacheFile.copy("${pathFinal.path}/$nameFile");
  } catch (_) {
    return null;
  }
}