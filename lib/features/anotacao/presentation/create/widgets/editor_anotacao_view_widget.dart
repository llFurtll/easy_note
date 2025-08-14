import 'dart:io';

import 'package:screen_manager/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart' as qx;

import '../../../../../core/widgets/spacer.dart';
import '../controller/anotacao_controller.dart';

class EditorAnotacaoViewWidget extends ScreenWidget<AnotacaoController> {
  const EditorAnotacaoViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.backgroundImage,
      builder: (context, value, child) {
        String path = '';
        if (value != null) {
          path = value.pathImage;
        }

        return Container(
          decoration: BoxDecoration(
            image: path.isNotEmpty
                ? DecorationImage(
                    image: path.contains('lib')
                        ? AssetImage(path)
                        : FileImage(File(path)) as ImageProvider,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      // .withOpacity() é deprecado: use withValues
                      Colors.white.withValues(alpha: 0.5),
                      BlendMode.dstATop,
                    ),
                  )
                : null,
          ),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),
                  spacer(10.0),
                  _buildToolbar(context),
                  _buildEditor(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return TextFormField(
      onChanged: (value) =>
          controller.showConfig('AUTOSAVE') ? controller.autoSave() : null,
      controller: controller.titleController,
      focusNode: controller.titleFocus,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Título',
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      maxLines: null,
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          showDragHandle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),
      ),
      child: ValueListenableBuilder(
        valueListenable: controller.showToolbar,
        builder: (context, value, child) {
          return Visibility(
            visible: value,
            child: Column(
              children: [
                quill.QuillSimpleToolbar(
                  controller: controller.quillController,
                  config: quill.QuillSimpleToolbarConfig(
                    // Most flags antigos foram removidos; mantenha os essenciais:
                    multiRowsDisplay: false,
                    showAlignmentButtons: true,
                    showLeftAlignment:
                        controller.showConfig('MOSTRAALINHAMENTOESQUERDA'),
                    showCenterAlignment:
                        controller.showConfig('MOSTRAALINHAMENTOCENTRO'),
                    showRightAlignment:
                        controller.showConfig('MOSTRAALINHAMENTODIREITA'),
                    showJustifyAlignment:
                        controller.showConfig('MOSTRAJUSTIFICADO'),
                    showDividers: controller.showConfig('MOSTRASEPARADOR'),
                    showInlineCode: controller.showConfig('MOSTRAINLINECODE'),
                    embedButtons: qx.FlutterQuillEmbeds.toolbarButtons(
                      imageButtonOptions: qx.QuillToolbarImageButtonOptions(
                        imageButtonConfig: qx.QuillToolbarImageConfig(
                          onImageInsertedCallback: (image) =>
                              controller.onImageAndVideoPickCallback(File(image)),
                        )
                      ),
                      videoButtonOptions: qx.QuillToolbarVideoButtonOptions(
                        videoConfig: qx.QuillToolbarVideoConfig(
                          onVideoInsertedCallback: (video) => 
                              controller.onImageAndVideoPickCallback(File(video)),
                        )
                      ),
                    ),
                  ),
                ),
                spacer(10.0),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditor() {
    return Expanded(
      child: quill.QuillEditor.basic(
        controller: controller.quillController,
        config: quill.QuillEditorConfig(
          // Estes nomes existem no v11 (confirmei na API ref)
          autoFocus: false,
          expands: true,
          scrollable: true,
          placeholder: 'Comece a digitar aqui...',
          padding: EdgeInsets.zero,
          // Suporte a imagens/vídeos dentro do editor:
          embedBuilders: qx.FlutterQuillEmbeds.defaultEditorBuilders(),
        ),
      ),
    );
  }
}
