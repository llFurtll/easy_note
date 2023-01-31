import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<bool> saveFile(String pathFile, String path, String nomeFile) async {
  final pathBase = (await getApplicationDocumentsDirectory()).path;
  final pathFinal = Directory("$pathBase/$path");

  try {
    if (!pathFinal.existsSync()) {
      pathFinal.createSync(recursive: true);
    }

    final file = XFile(pathFile);
    String pathToSave = "${pathFinal.path}/$nomeFile";
    file.saveTo(pathToSave);

    return true;
  } catch (_) {
    return false;
  }
}