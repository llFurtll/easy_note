import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

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
      body: _buildBody(context)
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
      pages: [
        _buildPage(),
        _buildPage()
      ],
      showBackButton: true,
      back: const Icon(Icons.arrow_back_ios, size: 20),
      backStyle: buttonStyle,
      showNextButton: true,
      next: const Icon(Icons.arrow_forward_ios, size: 20),
      nextStyle: buttonStyle,
      done: const Text("Continuar"),
      onDone: controller.onContinue,
      doneStyle: buttonStyle,
      dotsDecorator: DotsDecorator(
        color: Colors.black.withOpacity(0.5),
        activeColor: Colors.white
      ),
    );
  }

  PageViewModel _buildPage() {
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
      title: "EasyNote",
      body: "O Note virou Easy Note, contendo vários recursos",
      image: _buildImage()
    );
  }

  Widget _buildImage() {
    return Container(
      width: 250.0,
      height: 250.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage("https://www.freevector.com/uploads/vector/preview/31633/freevectorEcoBeachCleaningSickeray0422_generated.jpg"),
          fit: BoxFit.fill
        )
      ),
    );
  }
}