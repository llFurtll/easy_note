import 'package:flutter/material.dart';

import 'package:compmanager/screen_view.dart';

import '../injection/splash_injection.dart';
import '../controller/splash_controller.dart';

class Splash extends Screen {
  static const splashRoute = "/";

  const Splash({super.key});

  @override
  SplashInjection build(BuildContext context) {
    return SplashInjection(
      child: Builder(
        builder: (context) => SplashView(context: context)
      )
    );
  }
}

// ignore: must_be_immutable
class SplashView extends ScreenView<SplashController, SplashInjection> {
  SplashView({super.key, super.context});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Image.asset("lib/images/easy-note-logo.png"),
      ),
    );
  }
}