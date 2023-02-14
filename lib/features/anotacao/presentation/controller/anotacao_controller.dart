import 'dart:async';
import 'dart:io';

import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/embeds/embed_types.dart';

import '../../../../core/utils/save_file.dart';
import '../../../../core/widgets/custom_dialog.dart';
import '../../../configuracao/domain/usecases/get_find_all_config_by_modulo.dart';
import '../injection/anotacao_injection.dart';

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

    final idAnotacao = ModalRoute.of(context)!.settings.arguments as int?;

    if (idAnotacao != null) {
      isEdit = true;
    }
    
    Future.value()
      .then((_) => _loadConfigs())
      .then((_) => _loadAnotacao())
      .then((_) => isLoading.value = false);
  }

  void _loadAnotacao() async {
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

  Future<String?> onImageAndVideoPickCallback(File file) async {
    try {
      return await saveFile(file.path, "anotacao");
    } catch (_) {
      return null;
    }
  }

  Future<MediaPickSetting?> selectCameraPickSetting(BuildContext context) {
    final color = Theme.of(context).primaryColor.withOpacity(0.5);

    return showDialog<MediaPickSetting>(
      context: context,
      builder: (ctx) => CustomDialog(
        title: const Text("Selecione uma opção"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: color
              ),
              child: const Text(
                'Tirar uma foto',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
              onPressed: () => Navigator.pop(ctx, MediaPickSetting.Camera),
            ),
            Container(height: 1.0, color: Colors.black),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: color
              ),
              child: const Text(
                'Gravar um vídeo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
              onPressed: () => Navigator.pop(ctx, MediaPickSetting.Video),
            ),
          ],
        ),
      ),
    );
  }

  Future<MediaPickSetting?> selectMediaPickSetting(BuildContext context) {
    final color = Theme.of(context).primaryColor.withOpacity(0.5);

    return showDialog<MediaPickSetting>(
      context: context,
      builder: (ctx) => CustomDialog(
        title: const Text("Selecione uma opção"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: color
              ),
              child: const Text(
                'Abrir da galeria',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
              onPressed: () => Navigator.pop(ctx, MediaPickSetting.Gallery),
            ),
            Container(height: 1.0, color: Colors.black),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: color
              ),
              child: const Text(
                'Link',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
              onPressed: () => Navigator.pop(ctx, MediaPickSetting.Link),
            ),
          ],
        ),
      ),
    );
  }
}