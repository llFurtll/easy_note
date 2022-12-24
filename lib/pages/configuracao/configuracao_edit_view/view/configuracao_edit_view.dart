import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../controller/configuracao_edit_view_controller.dart';
import '../injection/configuracao_edit_view_injection.dart';
import '../widgets/appbar_configuracao_edit_view_widget.dart';

class ConfiguracaoEdit extends Screen {
  static const routeConfigEdit = "/config/edit";

  const ConfiguracaoEdit({super.key});

  @override
  ConfiguracaoEditViewInjection build(BuildContext context) {
    return ConfiguracaoEditViewInjection(
      child: Builder(
        builder: (context) => ConfiguracaoEditView(context: context),
      )
    );
  }

}

// ignore: must_be_immutable
class ConfiguracaoEditView extends ScreenView<ConfiguracaoEditViewController, ConfiguracaoEditViewInjection> {
  ConfiguracaoEditView({super.key, super.context});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBarConfiguracaoEditViewWidget(context: context),
      ),
    );
  }
}