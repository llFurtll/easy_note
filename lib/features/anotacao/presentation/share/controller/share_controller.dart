import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:compmanager/screen_controller.dart';
import 'package:easy_note/core/utils/create_dir.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

import '../../../../../core/adapters/share_file_easy_note.dart';
import '../../../../../core/arguments/share_anotacao_arguments.dart';
import '../../../../../core/enum/type_share.dart';
import '../../../../../core/widgets/custom_dialog.dart';
import '../../../../../core/widgets/show_loading.dart';

class ShareController extends ScreenController {
  final isLoading = ValueNotifier(true);
  final boundaryKey = GlobalKey();
  final shareFile = ShareFileEasyNoteImpl();

  late final ShareAnotacaoArguments args;
  late final QuillController qullController;

  @override
  void onInit() {
    super.onInit();

    args = ModalRoute.of(context)!.settings.arguments as ShareAnotacaoArguments;
    qullController = QuillController(
      document: Document.fromJson(jsonDecode(args.anotacao.observacao!)),
      selection: const TextSelection.collapsed(offset: 0)
    );
    isLoading.value = false;
  }

  Future<void> share() async {
    Future.value()
      .then((_) => showLoading(context))
      .then((_) async {
        switch (args.typeShare) {
          case TypeShare.pdf:
            return _createPdf();
          default:
            return await _createImageShare();
        }
      })
      .then((value) {
        Navigator.of(context).pop();
        if (value.isEmpty) {
          CustomDialog.error(
            "Não foi possível gerar o arquivo para compartilhamento, "
            "tente novamente!",
            context
          );
          
          return;
        }

        shareFile.shareFiles([File(value)]);
      });
  }

  Future<String> _createImageShare() async {
    try {
      final boundary =
        boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(
        pixelRatio: MediaQuery.of(context).devicePixelRatio
      );

      final dir = await createDir("share/image");
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = bytes!.buffer.asUint8List();

      final file = File("$dir/anotacao-${args.anotacao.id}.png");
      await file.writeAsBytes(pngBytes);

      return file.path;
    } catch (_) {
      return "";
    }
  }

  Future<String> _createPdf() async {
    String image = "";
    if (args.showImage) {
      try {
        if (args.anotacao.imagemFundo!.contains("lib")) {
          ByteData bytes = await rootBundle.load(args.anotacao.imagemFundo!);
          image = base64Encode(MemoryImage(bytes.buffer.asUint8List()).bytes);
        } else {
          image = base64Encode(MemoryImage(
            File(args.anotacao.imagemFundo!).readAsBytesSync()
          ).bytes);
        }
      } catch (e) {
        image = "";
      }
    }

    final delta = <Map<String, dynamic>>[...jsonDecode(args.anotacao.observacao!)];
    final converter = QuillDeltaToHtmlConverter(delta);
    final html = """
      <html>
        <head>
          <style>
            .title {
              color: black;
              font-size: 25px;
              font-weight: bold;
            }
          </style>
        </head>
        <body>
          <span class="title">${args.anotacao.titulo}</span>
          ${converter.convert()}
        </body>
      </html>
    """;
    final dir = await createDir("share/pdf");
    final file = await FlutterHtmlToPdf.convertFromHtmlContent(
      html,
      dir,
      "anotacao-${args.anotacao.id}"
    );

    return file.path;
  }
}