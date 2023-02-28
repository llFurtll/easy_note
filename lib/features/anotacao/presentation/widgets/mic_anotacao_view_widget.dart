import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../controller/anotacao_controller.dart';

class MicAnotacaoViewWidget extends ScreenWidget<AnotacaoController> {
  const MicAnotacaoViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final color = Theme.of(context).primaryColor;

    return ValueListenableBuilder(
      valueListenable: controller.isListen,
      builder: (context, value, child) {
        return AlertDialog(
          title: const Text("Pressione para ouvir"),
          content: GestureDetector(
            onLongPress: controller.onListen,
            onLongPressUp: controller.onCancelListen,
            child: AnimatedContainer(
              width: value ? 100.0 : 70.0,
              height: value ? 100.0 : 70.0,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color
              ),
              child: const Icon(Icons.mic, color: Colors.white, size: 30.0),
            ),
          ),
        );
      },
    );
  }
}