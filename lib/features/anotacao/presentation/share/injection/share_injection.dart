import 'package:flutter/material.dart';
import 'package:screen_manager/screen_injection.dart';
import 'package:screen_manager/screen_view.dart';

import '../controller/share_controller.dart';

class ShareInjection extends ScreenInjection<ShareController> {
  ShareInjection({
    super.key,
    required ScreenBridge child
  }) :
  super(
    child: child,
    controller: ShareController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}