import 'package:screen_manager/screen_widget.dart';
import 'package:easy_note/core/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

import '../controller/home_controller.dart';

class DeleteAnotacaoViewWidget extends ScreenWidget<HomeController> {
  final String titleAnotacao;

  const DeleteAnotacaoViewWidget({super.key, required this.titleAnotacao});

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return CustomDialog(
      type: CustomDialogEnum.warning,
      content: Text(
        "Deseja deletar a anotação $titleAnotacao?",
        style: const TextStyle(fontWeight: FontWeight.bold)
      ), 
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red
          ),
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            "Não",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent
            )
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.greenAccent
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            "Sim",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green
            )
          ),
        ),
      ],
    );
  }
}
