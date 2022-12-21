import 'package:flutter/material.dart';

import 'package:compmanager/screen_controller.dart';

class HomeViewController extends ScreenController {
  final FocusNode focusNode = FocusNode();

  void removeFocus() {
    focusNode.unfocus();
  }

  bool verifySize(BoxConstraints constraints) {
    var height = MediaQuery.of(context).padding.top;
    var top = constraints.biggest.height;
    if (top == height + kToolbarHeight) {
      return true;
    } else {
      return false;
    }
  }
}