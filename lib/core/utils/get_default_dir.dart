import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<Directory> getDefaultDir({String folder = ""}) async {
  final dirDefault = await getApplicationDocumentsDirectory();
  if (folder.isNotEmpty) {
    Directory newDir = Directory("${dirDefault.path}/$folder");
    return newDir;
  }

  return dirDefault;
}