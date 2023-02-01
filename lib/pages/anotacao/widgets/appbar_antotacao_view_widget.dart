import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../controller/anotacao_controller.dart';

class AppBarAnotacaoViewWidget extends ScreenWidget<AnotacaoController> with PreferredSizeWidget {
  const AppBarAnotacaoViewWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: _buildLeading(context),
      actions: _buildActions(),
    );
  }
  
  Widget _buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back_ios, color: Colors.black)
    );
  }

  List<Widget> _buildActions() {
    return [
      Container(
        padding: const EdgeInsets.only(right: 10.0),
        child: Wrap(
          children: [
            ValueListenableBuilder(
              valueListenable: controller.showIcones,
              builder: (BuildContext context, bool value, Widget? widget) {
                return Card(
                  elevation: 3.0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: AnimatedContainer(
                    width: _returnSizeContainer(),
                    height: 48.0,
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 500),
                    child: Wrap(
                      children: [
                        _iconOpenItens(value),
                        ..._iconsActions().map((e) => value ? e : const SizedBox(height: 0.0, width: 0.0))
                      ],
                    ),
                  )
                );
              },
            ),
          ],
        ),
      )
    ];
  }

   IconButton _iconOpenItens(bool close) {
    final showIcones = controller.showIcones;

    return IconButton(
      tooltip: close ? "Fechar menu" : "Abrir menu",
      onPressed: () => close ? showIcones.value = false : showIcones.value = true,
      icon: Icon(close ? Icons.close : Icons.menu),
      color: Colors.black,
      padding: EdgeInsets.zero,
      splashRadius: 25.0,
    );
  }

  List<Widget> _iconsActions() {
    return [
      Visibility(
        visible: controller.isEdit,
        child: IconButton(
          tooltip: "Compartilhar",
          onPressed: () {},
          icon: const Icon(Icons.ios_share_outlined),
          color: Colors.black,
          disabledColor: Colors.grey,
          padding: EdgeInsets.zero,
          splashRadius: 25.0,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.mic),
        color: Colors.black,
        disabledColor: Colors.grey,
        padding: EdgeInsets.zero,
        splashRadius: 25.0,
      ),
      IconButton(
        color: Colors.black,
        onPressed: () {},
        icon: const Icon(Icons.photo),
        padding: EdgeInsets.zero,
        splashRadius: 25.0,
      )
    ];
  }

  double _returnSizeContainer() {
    bool isEdit = controller.isEdit;
    bool showIcones = controller.showIcones.value;

    double baseSize = 48.0;
    int qtdIcones = 3;

    if (!showIcones) {
      return baseSize;
    }
    
    if (isEdit) {
      qtdIcones++;
    }

    return baseSize * qtdIcones;
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}