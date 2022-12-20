import 'package:flutter/material.dart';

import 'package:compmanager/screen_controller.dart';

class HomeViewController extends ScreenController {
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  bool get isExpanded =>
    scrollController.hasClients && scrollController.offset > (280 - kToolbarHeight);

  void removeFocus() {
    focusNode.unfocus();
  }
}