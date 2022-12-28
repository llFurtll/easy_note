import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/spacer.dart';
import '../controller/novo_detalhe_controller.dart';
import '../injection/novo_detalhe_injection.dart';

class NovoDetalhe extends Screen {
  static const routeNovoDetalhe = "/novo/detalhe";

  const NovoDetalhe({super.key});

  @override
  ScreenInjection<ScreenController> build(BuildContext context) {
    return NovoDetalheInjection(
      child: Builder(
        builder: (context) => NovoDetalheView(context: context),
      )
    );
  }
}

// ignore: must_be_immutable
class NovoDetalheView extends ScreenView<NovoDetalheController, NovoDetalheInjection> {
  NovoDetalheView({super.key, super.context});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImage(context)
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      width: 200,
      height: 200,
    );
  }

  Widget _buildText() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        "EasyNote",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
          height: 2.0
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDescription() {
    return const Text(
      "Agora o Note se transformou no EasyNote, tenha toda a funcionalidades " 
      "mais poderosas de um aplicativo",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
        color: Colors.white,
        letterSpacing: 1.2,
        height: 1.3
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSlide() {
    return ValueListenableBuilder(
      valueListenable: controller.currentPage,
      builder: (context, value, child) {
        return Wrap(
          spacing: 10,
          children: [
            ...List.generate(5, (index) => _buildItemSlide(index))
          ],
        );
      },
    );
  }

  Widget _buildItemSlide(int index) {
    return Container(
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: controller.currentPage.value == index ? Colors.white : Colors.black.withOpacity(0.5),
      ),
    );
  }
}