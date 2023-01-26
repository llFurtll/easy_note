import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../../controller/configuracao_edit_controller.dart';

class ListConfiguracaoEditViewWidget extends ScreenWidget<ConfiguracaoEditController> {
  const ListConfiguracaoEditViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (context, value, child) {
        if (value) {
          return const Center(child: CircularProgressIndicator());
        }

        final isError = controller.isError;

        if (isError) {
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: const Center(
              child: Text(
                "Falha ao carregar as versões, tente novamente!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return ListView(
          children: controller.configs,
        );
      },
    );
  }
}