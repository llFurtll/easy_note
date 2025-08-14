import 'dart:io';
import 'package:share_plus/share_plus.dart';

abstract class ShareFileEasyNote {
  Future<void> shareFiles(List<File> files, {String? text, String? subject});
}

class ShareFileEasyNoteImpl extends ShareFileEasyNote {
  @override
  Future<void> shareFiles(List<File> files, {String? text, String? subject}) async {
    final xFiles = files.map((f) => XFile(f.path)).toList();

    // Em iPad é recomendado informar sharePositionOrigin (opcional)
    await SharePlus.instance.share(
      ShareParams(
        files: xFiles,
        text: text,
        subject: subject,
        // sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1), // opcional (iPad)
      ),
    );
  }
}
