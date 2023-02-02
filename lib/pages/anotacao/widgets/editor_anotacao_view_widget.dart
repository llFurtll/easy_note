import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';

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
              _buildTitle()
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
}