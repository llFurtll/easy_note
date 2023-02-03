import 'package:compmanager/screen_widget.dart';
import 'package:easy_note/core/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../controller/anotacao_controller.dart';

class EditorAnotacaoViewWidget extends ScreenWidget<AnotacaoController> {
  const EditorAnotacaoViewWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _buildBody();
  }

  Widget _buildBody() {
    return Container(
      color: Colors.red,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              spacer(10.0),
              _buildToolbar(),
              spacer(10.0),
              _buildEditor()
            ],
          ),
        )
      ),
    );
  }

  Widget _buildTitle() {
    return TextFormField(
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "Título",
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 18.0
        )
      ),
    );
  }

  Widget _buildToolbar() {
    return QuillToolbar.basic(
      iconTheme: const QuillIconTheme(
        borderRadius: 10.0
      ),
      controller: controller.quillController,
      locale: const Locale("pt-BR"),
      toolbarIconAlignment: WrapAlignment.start
    );
  }

  Widget _buildEditor() {
    return Expanded(
      child: SizedBox(
        child: QuillEditor.basic(
          controller: controller.quillController,
          readOnly: false
        ),
      ),
    );
  }
}