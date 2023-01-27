import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../controller/configuracao_edit_controller.dart';
import '../injection/configuracao_edit_injection.dart';
import '../widgets/appbar_configuracao_edit_view_widget.dart';
import '../widgets/lista/list_configuracao_edit_view_widget.dart';

class ConfiguracaoEdit extends Screen {
  static const routeConfigEdit = "/config/edit";

  const ConfiguracaoEdit({super.key});

  @override
  ConfiguracaoEditInjection build(BuildContext context) {
    return ConfiguracaoEditInjection(
      child: const ScreenBridge<ConfiguracaoEditController, ConfiguracaoEditInjection>(
        child: ConfiguracaoEditView(),
      )
    );
  }

}

// ignore: must_be_immutable
class ConfiguracaoEditView extends ScreenView<ConfiguracaoEditController> {
  const ConfiguracaoEditView({super.key});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: AppBarConfiguracaoEditViewWidget(),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: const ListConfiguracaoEditViewWidget(),
      ),
    );
  }
}