import 'package:flutter/material.dart';

import '../pages/splash_view/view/splash_view.dart';
import '../pages/home_view/view/home_view.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    Splash.splashRoute: (context) => const Splash(),
    Home.homeRoute: (context) => const Home()
  };
}