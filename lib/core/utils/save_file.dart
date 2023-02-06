import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String?> saveFile(String pathFile, String path, String nomeFile) async {
  final pathBase = (await getApplicationDocumentsDirectory()).path;
  final pathFinal = Directory("$pathBase/$path");

  try {
    if (!pathFinal.existsSync()) {
      pathFinal.createSync(recursive: true);
    }

    final cacheFile = File(pathFile);
    String pathToSave = "${pathFinal.path}/$nomeFile";
    cacheFile.copySync(pathToSave);

    return pathToSave;
  } catch (_) {
    return null;
  }
}