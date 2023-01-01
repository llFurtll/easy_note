import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../../../data/databases/versao_data_source.dart';
import '../../../../data/repositories/versao_repository_impl.dart';
import '../../../../domain/entities/versao.dart';
import '../../../../domain/usecases/get_find_all_versao.dart';
import '../controller/novo_list_controller.dart';
import '../injection/novo_list_injection.dart';

class NovoList extends Screen {
  static const routeNovoList = "/novo/list";

  const NovoList({super.key});

  @override
  NovoListInjection build(BuildContext context) {
    return NovoListInjection(
      getFindAllVersao: GetFindAllVersao(
        VersaoRepositoryImpl(dataSource: VersaoDataSourceImpl())
      ),
      child: Builder(
        builder: (context) => NovoListView(context: context),
      )
    );
  }
}

// ignore: must_be_immutable
class NovoListView extends ScreenView<NovoListController, NovoListInjection> {
  NovoListView({super.key, required super.context});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ValueListenableBuilder<bool>(
        valueListenable: controller.isLoading,
        builder: (BuildContext context, bool value, Widget? widget) {
          if (value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.isError) {
            return const Center(
              child: Text(
                "Falha ao carregar as versões",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            );
          }

          return Container(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: controller.versoes.map((versao) => _buildItem(versao)).toList(),
            ),
          );
        },
      ),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56.0),
      child: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Versões do EasyNote"),
        automaticallyImplyLeading: false,
        leading: _buildBack(context),
      )
    );
  }

  Widget _buildBack(BuildContext context) {
    return IconButton(
      tooltip: "Voltar",
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  Widget _buildItem(Versao versao) {
    return ListTile(
      onTap: () async {
        controller.toSplashAtualizacao();
      },
      title: Text(
        "Versão ${versao.versao}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_sharp),
      subtitle: const Text("Clique para saber mais!"),
    );
  }
}