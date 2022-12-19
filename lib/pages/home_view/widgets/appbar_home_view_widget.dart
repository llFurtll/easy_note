import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../controller/home_view_controller.dart';
import '../injection/home_view_injection.dart';

// ignore: must_be_immutable
class AppBarHomeViewWidget extends ScreenWidget<HomeViewController, HomeViewInjection> {
  AppBarHomeViewWidget({super.key, super.context});

  final ValueNotifier isExpanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _buildAppBar();
  }
  
  @override
  void onInit() {
    super.onInit();

    controller.scrollController.addListener(_listenerAppBar);
  }

  ValueListenableBuilder _buildAppBar() {
    return ValueListenableBuilder(
      valueListenable: isExpanded,
      builder: (context, value, child) {
        return SliverAppBar(
          title: value ? const Text("Daniel Melonari") : null,
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 200,
          flexibleSpace: value ? const SizedBox.shrink() : const FlexibleSpaceBar(
                  title: Text("Legal"),
          ),
        );
      },
    );
  }

  void _listenerAppBar() {
    isExpanded.value = controller.isExpanded;
  }
}