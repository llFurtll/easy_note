import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../controller/home_controller.dart';
import '../injection/home_injection.dart';
import '../widgets/appbar_home_view_widget.dart';
import '../widgets/list_note_home_view_widget.dart';

class Home extends Screen {
  static const routeHome = "/home";

  const Home({super.key});

  @override
  HomeInjection build(BuildContext context) {
    return HomeInjection(
      child: const ScreenBridge<HomeController, HomeInjection>(
        child: HomeView(),
      )
    );
  }
}

// ignore: must_be_immutable
class HomeView extends ScreenView<HomeController> {
  const HomeView({super.key});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => controller.removeFocus(),
        child: CustomScrollView(
          slivers: [
            AppBarHomeViewWidget(context: context),
            ListNoteHomeViewWidget(context: context)
          ],
        ),
      )
    );
  }
}