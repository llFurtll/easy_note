import 'dart:io';

Future<bool> deleteFile(String path) async {
  try {
    File file = File(path);
    if (file.existsSync()) {
      file.deleteSync();
    }

    return true;
  } catch (_) {
    return false;
  }
}