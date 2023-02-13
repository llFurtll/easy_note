import 'dart:async';

import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:easy_note/features/anotacao/presentation/injection/anotacao_injection.dart';
import 'package:easy_note/features/configuracao/domain/usecases/get_find_all_config_by_modulo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class AnotacaoController extends ScreenController {
  final showIcones = ValueNotifier(false);
  final quillController = QuillController.basic();
  final locale = const Locale("pt", "BR");
  final showToolbar = ValueNotifier(false);
  final titleFocus = FocusNode();
  final isLoading = ValueNotifier(true);
  final configs = <String, int>{};
  
  late final Timer timer;

  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();

    timer = Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) => _showToolbarObserver()
    );
    
    Future.value()
      .then((_) => _loadConfigs())
      .then((_) => isLoading.value = false);
  }

  void _showToolbarObserver() {
    if (!titleFocus.hasFocus) {
      showToolbar.value = true;
    } else {
      showToolbar.value = false;
    }
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  void _loadConfigs() async {
    final usecase = ScreenInjection.of<AnotacaoInjection>(context).getFindAllConfigByModulo;
    final result = await usecase(FindAllConfigByModuloParams(modulo: "NOTE"));
    result.fold((left) => null, (right) => configs.addAll(right));
  }

  bool showConfig(String key) {
    return configs[key] == 1;
  }
}