import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<bool> saveFile(String pathFile, String path, String nomeFile) async {
  final pathBase = (await getApplicationDocumentsDirectory()).path;
  final pathFinal = Directory("$pathBase/$path");

  try {
    if (!pathFinal.existsSync()) {
      pathFinal.createSync(recursive: true);
    }

    final file = File(pathFile);
    String pathToSave = "${pathFinal.path}/$nomeFile";
    file.copy(pathToSave);

    return true;
  } catch (_) {
    return false;
  }
}