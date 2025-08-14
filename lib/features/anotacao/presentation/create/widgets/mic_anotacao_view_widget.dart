import 'package:avatar_glow/avatar_glow.dart';
import 'package:screen_manager/screen_widget.dart';
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
          title: Text(value ? "Ouvindo..." : "Pressione para falar"),
          content: GestureDetector(
            onLongPress: controller.onListen,
            onLongPressUp: controller.onCancelListen,
            child: AvatarGlow(
              glowColor: color,
              animate: value,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 1000),
              glowShape: BoxShape.circle,
              glowRadiusFactor: value ? 1.0 : 0.7, // substitui endRadius
              child: AnimatedContainer(
                width: value ? 100.0 : 80.0,
                height: value ? 100.0 : 80.0,
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: const Icon(Icons.mic, color: Colors.white, size: 30.0),
              ),
            )
          ),
        );
      },
    );
  }
}