import 'package:flutter/material.dart';
import 'package:screen_manager/screen_injection.dart';

import '../controller/share_controller.dart';

class ShareInjection extends ScreenInjection<ShareController> {
  ShareInjection({
    super.key,
    required super.child
  }) :
  super(
    controller: ShareController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}