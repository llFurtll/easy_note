import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../controller/configuracao_edit_view_controller.dart';
import '../injection/configuracao_edit_view_injection.dart';

// ignore: must_be_immutable
class AppBarConfiguracaoEditViewWidget extends ScreenWidget<ConfiguracaoEditViewController, ConfiguracaoEditViewInjection> {
  AppBarConfiguracaoEditViewWidget({super.key, super.context});

  late String title;

  @override
  void onInit() {
    super.onInit();

    String modulo = ModalRoute.of(controller.context)!.settings.arguments as String;

    switch (modulo) {
      case "NOTE":
        title = "Configuraçẽos de anotação";
        break;
      case "APP":
        title = "Configurações do aplicativo";
        break;
      default:
        title = "Configurações não encontrada";
    }
  }
  
  @override
  AppBar build(BuildContext context) {
    super.build(context);

    return AppBar(
      automaticallyImplyLeading: false,
      leading: _iconLeading(context),
      actions: [
        _actionSave()
      ],
      title: Text(title),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _iconLeading(BuildContext context) {
    return IconButton(
      tooltip: "Voltar",
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back_ios)
    );
  }

  Widget _actionSave() {
    return TextButton(
      onPressed: () async {},
      style: TextButton.styleFrom(
        foregroundColor: Colors.white
      ),
      child: const Text("Salvar"),
    );
  }
}