import 'package:flutter/material.dart';

import 'package:compmanager/screen_view.dart';

import '../injection/splash_view_injection.dart';
import '../controller/splash_view_controller.dart';

class Splash extends Screen {
  static const splashRoute = "/";

  const Splash({super.key});

  @override
  SplashViewInjection build(BuildContext context) {
    return SplashViewInjection(
      child: Builder(
        builder: (context) => SplashView(context: context)
      )
    );
  }
}

// ignore: must_be_immutable
class SplashView extends ScreenView<SplashViewController, SplashViewInjection> {
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