import 'package:screen_manager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/enum/type_share.dart';
import '../controller/anotacao_controller.dart';

class ShareAnotacaoViewWidget extends ScreenWidget<AnotacaoController> {
  const ShareAnotacaoViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          child: Icon(Icons.drag_handle, color: Colors.grey, size: 40.0),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Text(
            "Atenção, no caso do pdf, as imagens inseridas na anotação irão ser exibidas até o máximo 500x500 de altura/largura. "
            "Vídeos também não são suportados.",
            maxLines: null,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        TextButton(
          onPressed: () => controller.share(TypeShare.pdf),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15),
            foregroundColor: Colors.black,
          ),
          child: const Text(
            "Compartilhar anotação como PDF",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
          ),
        ),
        TextButton(
          onPressed: () => controller.share(TypeShare.image),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15),
            foregroundColor: Colors.black,
          ),
          child: const Text(
            "Compartilhar anotação como imagem",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
          ),
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          height: 50.0,
          margin: const EdgeInsets.only(bottom: 25.0, top: 15.0),
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "Cancelar",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            )
          ),
        )
      ],
    );
  }
}