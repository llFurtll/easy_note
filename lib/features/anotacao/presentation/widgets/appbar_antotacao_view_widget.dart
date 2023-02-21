import 'package:compmanager/screen_widget.dart';
import 'package:easy_note/features/anotacao/presentation/widgets/change_image_anotacao_view_widget.dart';
import 'package:flutter/material.dart';

import '../controller/anotacao_controller.dart';

class AppBarAnotacaoViewWidget extends ScreenWidget<AnotacaoController>
    with PreferredSizeWidget {
  const AppBarAnotacaoViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: ValueListenableBuilder(
        valueListenable: controller.ultimaAtualizacao,
        builder: (context, value, child) {
          return Text(
            value ?? "",
            maxLines: 2,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12.0,
              fontWeight: FontWeight.bold
            )
          );
        },
      ),
      leading: _buildLeading(context),
      actions: _buildActions(),
    );
  }

  Widget _buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black));
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
                          ..._iconsActions(context).map((e) => value
                              ? e
                              : const SizedBox(height: 0.0, width: 0.0))
                        ],
                      ),
                    ));
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
      onPressed: () =>
          close ? showIcones.value = false : showIcones.value = true,
      icon: Icon(close ? Icons.close : Icons.menu),
      color: Colors.black,
      padding: EdgeInsets.zero,
      splashRadius: 25.0,
    );
  }

  List<Widget> _iconsActions(BuildContext context) {
    return [
      ValueListenableBuilder(
        valueListenable: controller.isEdit,
        builder: (context, value, child) {
          return Visibility(
            visible: value,
            child: IconButton(
              tooltip: "Compartilhar",
              onPressed: () {},
              icon: const Icon(Icons.ios_share_outlined),
              color: Colors.black,
              disabledColor: Colors.grey,
              padding: EdgeInsets.zero,
              splashRadius: 25.0,
            ),
          );
        },
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.mic),
        color: Colors.black,
        disabledColor: Colors.grey,
        padding: EdgeInsets.zero,
        splashRadius: 25.0,
      ),
      ValueListenableBuilder(
        valueListenable: controller.backgroundImage,
        builder: (context, value, child) {
          final isFoto = value != null;

          return IconButton(
            tooltip: isFoto
                ? "Remover imagem de fundo"
                : "Adicionar imagem de fundo",
            color: Colors.black,
            onPressed: () {
              if (isFoto) {
                controller.changeBackground(null);
              } else {
                controller.unfocus();
                showBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0))),
                    backgroundColor: Colors.blueGrey[50],
                    context: context,
                    builder: (context) => const ChangeImageAnotacaoViewWiget());
              }
            },
            icon: Icon(isFoto ? Icons.no_photography : Icons.photo),
            padding: EdgeInsets.zero,
            splashRadius: 25.0,
          );
        },
      ),
    ];
  }

  double _returnSizeContainer() {
    bool isEdit = controller.isEdit.value;
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
