import 'dart:io';

import 'package:screen_manager/screen_widget.dart';
import 'package:easy_note/core/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

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
      padding: const EdgeInsets.all(10.0),
      child: RepaintBoundary(
        key: controller.boundaryKey,
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          elevation: 10.0,
          child: Container(
            decoration: args.showImage ? BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.5),
                  BlendMode.dstATop
                ),
                image: image!,
                fit: BoxFit.cover
              ),
            ) : null,
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 500.0,
            ),
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      args.anotacao.titulo!,
                      style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0
                    ),
                  ),
                ),
                spacer(10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                    child: Expanded(
                      child: QuillEditor(
                      controller: controller.qullController,
                      readOnly: true,
                      autoFocus: false,
                      expands: true,
                      focusNode: FocusNode(),
                      padding: EdgeInsets.zero,
                      scrollController: ScrollController(),
                      scrollable: true,
                      paintCursorAboveText: false,
                      enableInteractiveSelection: false,
                    ),
                    )
                ),
              ]
            )
          ),
        ),
      )
    );
  }
}