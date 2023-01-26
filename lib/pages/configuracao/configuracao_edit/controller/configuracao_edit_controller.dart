import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecases/get_find_all_config_by_modulo.dart';
import '../injection/configuracao_edit_injection.dart';
import '../widgets/lista/item_list_configuracao_edit_view_widget.dart';

class ConfiguracaoEditController extends ScreenController {
  final isLoading = ValueNotifier(true);
  final List<ItemListConfiguracaoEditViewWidget> configs = [];

  bool isError = false;

  @override
  void onInit() {
    super.onInit();

    String modulo = ModalRoute.of(context)!.settings.arguments as String;

    Future.value()
      .then((_) => _loadConfigs(modulo))
      .then((response) {
        if (response == null || response.isEmpty) {
          isError = true;
          return;
        }

        for (var identificador in response.keys) {
          configs.add(
            ItemListConfiguracaoEditViewWidget(identificador: identificador, valor: response[identificador]!)
          );
        }
      })
      .then((_) => isLoading.value = false);
  }

  Future<Map<String, int>?> _loadConfigs(String modulo) async {
    final getFindAllConfigByModulo = ScreenInjection.of<ConfiguracaoEditInjection>(context).getFindAllConfigByModulo;
    return await getFindAllConfigByModulo(FindAllConfigByModulo(modulo: modulo)); 
  }
}