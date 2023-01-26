import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../../../data/datasources/configuracao_data_source.dart';
import '../../../../data/repositories/configuracao_repository_impl.dart';
import '../../../../domain/usecases/get_find_all_config_by_modulo.dart';
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
      getFindAllConfigByModulo: GetFindAllConfigByModulo(
        ConfiguracaoRepositoryImpl(dataSource: ConfiguracaoDataSourceImpl())
      ),
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBarConfiguracaoEditViewWidget(context: context),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: const ListConfiguracaoEditViewWidget(),
      ),
    );
  }
}