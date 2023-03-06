import 'package:compmanager/screen_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../core/arguments/share_anotacao_arguments.dart';

class ShareController extends ScreenController {
  late final ShareAnotacaoArguments args;

  @override
  void onInit() {
    super.onInit();
    args = ModalRoute.of(context)!.settings.arguments as ShareAnotacaoArguments;
  }
}