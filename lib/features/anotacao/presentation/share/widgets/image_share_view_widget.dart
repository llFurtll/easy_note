import 'dart:io';

import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:screen_manager/screen_widget.dart';
import 'package:easy_note/core/widgets/spacer.dart';
import 'package:flutter/material.dart';

import '../controller/share_controller.dart';

class ImageShareViewWidget extends ScreenWidget<ShareController> {
  const ImageShareViewWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final args = controller.args;
    ImageProvider? image;
    if (args.showImage) {
      if (args.anotacao.imagemFundo!.contains("lib")) {
        image = AssetImage(args.anotacao.imagemFundo!);
      } else {
        image = FileImage(File(args.anotacao.imagemFundo!));
      }
    }

    return SingleChildScrollView(
      child: RepaintBoundary(
        key: controller.boundaryKey,
        child: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(15.0),
          constraints: const BoxConstraints(
            minWidth: double.infinity,
            minHeight: 100.0
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            image: args.showImage ? DecorationImage(
              image: image!,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.5),
                BlendMode.dstATop
              ),
            ) : null,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                args.anotacao.titulo!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0
                ),
              ),
              spacer(10.0),
              QuillEditor(
                embedBuilders: FlutterQuillEmbeds.builders(),
                autoFocus: false,
                controller: controller.quillController,
                expands: false,
                focusNode: FocusNode(),
                padding: EdgeInsets.zero,
                readOnly: true,
                scrollController: ScrollController(),
                scrollable: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}