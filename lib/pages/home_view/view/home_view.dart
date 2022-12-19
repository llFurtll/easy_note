import 'package:flutter/material.dart';

import 'package:compmanager/screen_view.dart';

import '../controller/home_view_controller.dart';
import '../injection/home_view_injection.dart';
import '../widgets/appbar_home_view_widget.dart';
import '../widgets/list_note_home_view_widget.dart';

class Home extends Screen {
  static const homeRoute = "/home";

  const Home({super.key});

  @override
  HomeViewInjection build(BuildContext context) {
    return HomeViewInjection(
      child: Builder(
        builder: (context) => HomeView(context: context),
      )
    );
  }
}

// ignore: must_be_immutable
class HomeView extends ScreenView<HomeViewController, HomeViewInjection> {
  HomeView({super.key, super.context});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          AppBarHomeViewWidget(context: context),
          ListNoteHomeViewWidget(context: context)
        ],
      )
    );
  }
}