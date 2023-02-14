import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../controller/splash_controller.dart';
import '../injection/splash_injection.dart';

class Splash extends Screen {
  static const routeSplash = "/";

  const Splash({super.key});

  @override
  SplashInjection build(BuildContext context) {
    return SplashInjection(
      child: const ScreenBridge<SplashController, SplashInjection>(
        child: SplashView()
      )
    );
  }
}

// ignore: must_be_immutable
class SplashView extends ScreenView<SplashController> {
  const SplashView({super.key});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Image.asset("lib/assets/images/easy-note-logo.png"),
      ),
    );
  }
}