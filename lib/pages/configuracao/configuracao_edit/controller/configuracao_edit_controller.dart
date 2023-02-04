import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/widgets/show_loading.dart';
import '../../../../core/widgets/show_message.dart';
import '../../../../domain/entities/configuracao.dart';
import '../../../../domain/usecases/get_find_all_config_by_modulo.dart';
import '../../../../domain/usecases/get_save_configuracao.dart';
import '../injection/configuracao_edit_injection.dart';
import '../widgets/lista/item_list_configuracao_edit_view_widget.dart';

class ConfiguracaoEditController extends ScreenController {
  final isLoading = ValueNotifier(true);
  final List<ItemListConfiguracaoEditViewWidget> configs = [];
  
  late final String title;

  bool isError = false;

  @override
  void onInit() {
    super.onInit();

    String modulo = ModalRoute.of(context)!.settings.arguments as String;

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

    Future.value()
      .then((_) => _loadConfigs(modulo))
      .then((response) {
        response.fold((left) {
          isError = true;
          return;
        }, (right) {
           if (right.isEmpty) {
            isError = true;
            return;
          }

          for (var identificador in right.keys) {
            configs.add(
              ItemListConfiguracaoEditViewWidget(identificador: identificador, valor: right[identificador]!)
            );
          }
        });
      })
      .then((_) => isLoading.value = false);
  }

  Future<Result<Failure, Map<String, int>>> _loadConfigs(String modulo) async {
    final getFindAllConfigByModulo = ScreenInjection.of<ConfiguracaoEditInjection>(context).getFindAllConfigByModulo;
    return await getFindAllConfigByModulo(FindAllConfigByModulo(modulo: modulo)); 
  }

  void saveConfigs() {
    final getSaveConfiguracao = ScreenInjection.of<ConfiguracaoEditInjection>(context).getSaveConfiguracao;
    String modulo = ModalRoute.of(context)!.settings.arguments as String;

    showLoading(context);

    Future.value()
      .then((_) async {
        for (var item in configs) {
          final config = Configuracao(
            id: null,
            identificador: item.identificador,
            valor: item.valor,
            modulo: modulo
          );

          final result = await getSaveConfiguracao(SaveConfiguracaoParams(
            configuracao: config
          ));

          return result.fold((left) => true, (right) {
            if (right == 0) {
              return true;
            }

            return false;
          });
        }

        return false;
      })
      .then((result) {
        Navigator.of(context).pop();

        if (result) {
          showMessage(context, "Erro ao salvar as configurações, tente novamente!");
        } else {
          showMessage(context, "Configurações atualizadas com sucesso!");
        }
      });
  }
}