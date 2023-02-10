import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import '../../../../core/widgets/spacer.dart';
import '../controller/anotacao_controller.dart';

class EditorAnotacaoViewWidget extends ScreenWidget<AnotacaoController> {
  const EditorAnotacaoViewWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            spacer(10.0),
            _buildEditor(),
            _buildToolbar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        focusNode: controller.titleFocus,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Título",
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18.0
          )
        ),
      ),
    );
  }

  Widget _buildToolbar() {
    return ValueListenableBuilder(
      valueListenable: controller.showToolbar,
      builder: (context, value, child) {
        return Visibility(
          visible: value,
          child: QuillToolbar.basic(
            embedButtons: FlutterQuillEmbeds.buttons(),
            locale: controller.locale,
            controller: controller.quillController,
            multiRowsDisplay: false
          )
        );
      },
    );
  }

  Widget _buildEditor() {
    return Expanded(
      child: QuillEditor(
        embedBuilders: FlutterQuillEmbeds.builders(),
        scrollController: ScrollController(),
        controller: controller.quillController,
        autoFocus: false,
        expands: true,
        scrollable: true,
        focusNode: FocusNode(),
        enableInteractiveSelection: true,
        readOnly: false,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      )
    );
  }
}