import 'package:compmanager/screen_widget.dart';
import 'package:easy_note/core/widgets/spacer.dart';
import 'package:flutter/material.dart';

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
        child: Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              spacer(10.0),
              _buildToolbar(context),
              spacer(10.0),
              _buildEditor(context)
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

  Widget _buildToolbar(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget _buildEditor(BuildContext context) {
    return const SizedBox.shrink();
  }
}