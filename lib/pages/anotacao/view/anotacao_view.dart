import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../controller/anotacao_controller.dart';
import '../injection/anotacao_injection.dart';
import '../widgets/appbar_antotacao_view_widget.dart';

class AnotacaoScreen extends Screen {
  static const routeAnotacao = "/anotacao";

  const AnotacaoScreen({super.key});

  @override
  AnotacaoInjection build(BuildContext context) {
    return AnotacaoInjection(
      child: const ScreenBridge<AnotacaoController, AnotacaoInjection>(
        child: AnotacaoView()
      )
    );
  }
}

class AnotacaoView extends ScreenView<AnotacaoController> {
  const AnotacaoView({super.key});

  @override
  Scaffold build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarAnotacaoViewWidget(),
    );
  }
}