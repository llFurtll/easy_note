import 'package:flutter/material.dart';

import 'package:compmanager/screen_controller.dart';

class HomeViewController extends ScreenController {
  ScrollController scrollController = ScrollController();

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  bool get isExpanded =>
    scrollController.hasClients && scrollController.offset > (200 - kToolbarHeight);
}