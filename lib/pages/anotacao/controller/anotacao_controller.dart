import 'package:compmanager/screen_controller.dart';
import 'package:flutter/material.dart';

class AnotacaoController extends ScreenController {
  final showIcones = ValueNotifier(false);
  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();

    int? idAnotacao = ModalRoute.of(context)!.settings.arguments as int?;
    if (idAnotacao != null) {
      isEdit = true;
    }
  }
}