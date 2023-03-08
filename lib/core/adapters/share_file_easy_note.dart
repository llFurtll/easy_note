import 'dart:io';
import 'package:share_plus/share_plus.dart';

abstract class ShareFileEasyNote {
  void shareFiles(List<File> files);
}

class ShareFileEasyNoteImpl extends ShareFileEasyNote {
  @override
  void shareFiles(List<File> files) {
    List<XFile> xFiles = [];
    for (var file in files) {
      xFiles.add(XFile(file.path));
    }

    Share.shareXFiles(xFiles);
  }
}