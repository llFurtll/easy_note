import 'package:compmanager/screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class AnotacaoController extends ScreenController with WidgetsBindingObserver {
  final showIcones = ValueNotifier(false);
  final quillController = QuillController.basic();
  final locale = const Locale("pt", "BR");
  final keyboard = ValueNotifier(false);

  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);

    int? idAnotacao = ModalRoute.of(context)!.settings.arguments as int?;
    if (idAnotacao != null) {
      isEdit = true;
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    check() => keyboard.value = WidgetsBinding.instance.window.viewInsets.bottom > 0;

    Future.delayed(const Duration(milliseconds: 100), () => check());
  }
}