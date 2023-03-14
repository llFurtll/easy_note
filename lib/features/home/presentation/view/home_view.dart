import 'package:screen_manager/screen_receive.dart';
import 'package:screen_manager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../../anotacao/presentation/create/view/anotacao_view.dart';
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
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (context, value, child) {
        if (value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          body: GestureDetector(
            onTap: controller.removeFocus,
            child: const CustomScrollView(
              slivers: [
                AppBarHomeViewWidget(),
                ListNoteHomeViewWidget()
              ],
            ),
          ),
          floatingActionButton: _buildFab(context),
        );
      },
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      elevation: 10,
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => Navigator.pushNamed(context, AnotacaoScreen.routeAnotacao),
      child: const Icon(Icons.add),
    );
  }

  @override
  void receive(String message, value, {ScreenReceive? screen}) {
    controller.receive(message, value, screen: screen);
  }
}