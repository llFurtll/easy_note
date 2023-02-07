import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'create_dir.dart';
import 'get_default_dir.dart';

Future<String?> saveFile(String pathFile, String folder) async {
  bool? dir = await createDir(folder);
  String ext = extension(pathFile);
  String nameFile = "${UniqueKey().hashCode}$ext";

  try {
    if (dir != null) {
      String path = await getDefaultDir();
      path = "$path/$folder";
      File cacheFile = File(pathFile);
      await cacheFile.copy("$path/$nameFile");


      return await Future.delayed(const Duration(seconds: 5), () => nameFile);
    }

    return null;
  } catch (_) {
    return null;
  }
}