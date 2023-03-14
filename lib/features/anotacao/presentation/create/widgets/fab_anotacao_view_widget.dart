import 'package:screen_manager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../controller/anotacao_controller.dart';

class FabAnotacaoViewWidget extends ScreenWidget<AnotacaoController> {
  const FabAnotacaoViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FloatingActionButton(
      onPressed: controller.save,
      child: const Icon(Icons.save),
    );
  }
}
