import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> saveFile(String pathFile, String folder) async {
  String pathBase = (await getApplicationDocumentsDirectory()).path;
  File pathFinal = File("$pathBase/$folder/");
  final ext = extension(pathFile);

  final nameFile = "${UniqueKey().hashCode}$ext";

  try {
    if (!pathFinal.existsSync()) {
      pathFinal.createSync(recursive: true);
    }

    File cacheFile = File(pathFile);
    String pathToSave = "${pathFinal.path}/$nameFile";
    await cacheFile.copy(pathToSave);

    return "$pathBase/$folder/$nameFile";
  } catch (_) {
    return null;
  }
}