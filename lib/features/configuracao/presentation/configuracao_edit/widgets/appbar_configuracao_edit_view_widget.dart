import 'package:screen_manager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../controller/configuracao_edit_controller.dart';

// ignore: must_be_immutable
class AppBarConfiguracaoEditViewWidget extends ScreenWidget<ConfiguracaoEditController> {
  const AppBarConfiguracaoEditViewWidget({super.key, super.context});
  
  @override
  AppBar build(BuildContext context) {
    super.build(context);

    return AppBar(
      automaticallyImplyLeading: false,
      leading: _iconLeading(context),
      actions: [
        _actionSave()
      ],
      title: Text(
        controller.title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _iconLeading(BuildContext context) {
    return IconButton(
      tooltip: "Voltar",
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back_ios, color: Colors.white)
    );
  }

  Widget _actionSave() {
    return TextButton(
      onPressed: controller.saveConfigs,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white
      ),
      child: const Text(
        "Salvar",
        style: TextStyle(fontWeight: FontWeight.bold)
      ),
    );
  }
}