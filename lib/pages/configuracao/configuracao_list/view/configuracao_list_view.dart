import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../configuracao_edit/view/configuracao_edit_view.dart';

// ignore: must_be_immutable
class ConfiguracaoView extends ScreenView<NoController, NoScreenInjection> {
  static const routeConfig = "/config";

  ConfiguracaoView({super.key});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfo(),
            _buildDivider(),
            _buildSecao([
              _itemSecao("Configurações do aplicativo", const Icon(Icons.app_settings_alt), () {
                Navigator.of(context).pushNamed(ConfiguracaoEdit.routeConfigEdit, arguments: "APP");
              }),
              _buildDivider(),
              _itemSecao("Configurações de anotações", const Icon(Icons.note), () {
                Navigator.of(context).pushNamed(ConfiguracaoEdit.routeConfigEdit, arguments: "NOTE");
              }),
            ])
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: false,
      leading: _iconLeading(context),
      title: const Text("Configurações do EasyNote"),
    );
  }

  Widget _iconLeading(BuildContext context) {
    return IconButton(
      tooltip: "Voltar",
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Widget _buildInfo() {
    return const Text(
      "Aqui nas configurações é possível realizar algumas customizações no EasyNote.",
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _buildSecao(List<Widget> widgets) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 5.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...widgets.map((element) => element)
        ],
      ),
    );
  }

  Widget _itemSecao(String title, Icon icon, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: 10.0,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                icon,
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            const Icon(Icons.arrow_forward_outlined)
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.black
    );
  }
}