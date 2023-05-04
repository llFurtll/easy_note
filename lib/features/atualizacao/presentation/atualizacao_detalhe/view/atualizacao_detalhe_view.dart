import 'package:flutter_svg/flutter_svg.dart';
import 'package:screen_manager/screen_controller.dart';
import 'package:screen_manager/screen_injection.dart';
import 'package:screen_manager/screen_view.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../domain/entities/atualizacao.dart';
import '../controller/atualizacao_detalhe_controller.dart';
import '../injection/atualizacao_detalhe_injection.dart';

class AtualizacaoDetalhe extends Screen {
  static const routeAtualizacaoDetalhe = "/atualizacao/detalhe";

  const AtualizacaoDetalhe({super.key});

  @override
  ScreenInjection<ScreenController> build(BuildContext context) {
    return AtualizacaoDetalheInjection(
      child: const ScreenBridge<AtualizacaoDetalheController, AtualizacaoDetalheInjection>(
        child: AtualizacaoDetalheView(),
      )
    );
  }
}

// ignore: must_be_immutable
class AtualizacaoDetalheView extends ScreenView<AtualizacaoDetalheController> {
  const AtualizacaoDetalheView({super.key});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ValueListenableBuilder(
        valueListenable: controller.isLoading,
        builder: (context, value, child) {
          final isError = controller.isError;

          if (value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (isError) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: const Center(
                child: Text(
                  "Falha ao carregar os dados da atualização, por favor tente novamente!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return _buildBody(context);
        },
      )
    );
  }

  Widget _buildBody(BuildContext context) {
    final buttonStyle =  ButtonStyle(
      foregroundColor: const MaterialStatePropertyAll(Colors.white),
      overlayColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.2))
    );

    return IntroductionScreen(
      globalBackgroundColor: Theme.of(context).primaryColor,
      isBottomSafeArea: true,
      isTopSafeArea: true,
      pages: controller.lista.map((item) => _buildPage(item, context)).toList(),
      showBackButton: true,
      back: const Icon(Icons.arrow_back_ios, size: 20),
      backStyle: buttonStyle,
      showNextButton: true,
      next: const Icon(Icons.arrow_forward_ios, size: 20),
      nextStyle: buttonStyle,
      done: const Text(
        "Continuar",
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
      onDone: controller.onContinue,
      doneStyle: buttonStyle,
      dotsDecorator: DotsDecorator(
        color: Colors.black.withOpacity(0.5),
        activeColor: Colors.white
      ),
    );
  }

  PageViewModel _buildPage(Atualizacao atualizacao, BuildContext context) {
    return PageViewModel(
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
        bodyTextStyle: TextStyle(
          color: Colors.white,
          letterSpacing: 1.2,
          fontSize: 16.0,
          height: 1.3
        ),
      ),
      title: atualizacao.cabecalho,
      body: atualizacao.descricao,
      image: _buildImage(atualizacao, context),
    );
  }

  Widget _buildImage(Atualizacao atualizacao, BuildContext context) {
    if (atualizacao.imagem!.contains("svg")) {
      return SvgPicture.asset(
        atualizacao.imagem!,
        width: 250.0,
        height: 250.0,
        color: Colors.white
      );
    }

    return Container(
      width: 250.0,
      height: 250.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(atualizacao.imagem!),
          fit: BoxFit.cover
        )
      ),
    );
  }
}