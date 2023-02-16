import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/embeds/embed_types.dart';

import '../../../../core/utils/save_file.dart';
import '../../../../core/widgets/custom_dialog.dart';
import '../../../../core/widgets/show_loading.dart';
import '../../../../core/widgets/show_message.dart';
import '../../../configuracao/domain/usecases/get_find_all_config_by_modulo.dart';
import '../../domain/entities/anotacao.dart';
import '../../domain/usecases/get_save_anotacao.dart';
import '../injection/anotacao_injection.dart';
import '../models/background_anotacao_model.dart';

class AnotacaoController extends ScreenController {
  final showIcones = ValueNotifier(false);
  final quillController = QuillController.basic();
  final locale = const Locale("pt", "BR");
  final showToolbar = ValueNotifier(false);
  final titleFocus = FocusNode();
  final titleController = TextEditingController();
  final editorFocus = FocusNode();
  final isLoading = ValueNotifier(true);
  final configs = <String, int>{};
  final images = <BackgroundAnotacaoModel>[];
  final backgroundImage = ValueNotifier<BackgroundAnotacaoModel?>(null);
  final anotacao = Anotacao();

  late final Timer timer;

  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();

    timer = Timer.periodic(
        const Duration(milliseconds: 500), (timer) => _showToolbarObserver());

    final idAnotacao = ModalRoute.of(context)!.settings.arguments as int?;
    if (idAnotacao != null) {
      isEdit = true;
    }

    Future.value()
        .then((_) => _loadConfigs())
        .then((_) => _loadImages())
        .then((_) => _loadAnotacao(idAnotacao))
        .then((_) => isLoading.value = false);
  }

  void _loadAnotacao(int? idAnotacao) async {}

  void _loadImages() async {
    final manifest = await rootBundle.loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifest);

    final assetsProject = manifestMap.keys
        .where((key) => key.contains("lib/assets/images/anotacao"))
        .where((key) => key.contains(".jpg"))
        .toList();

    for (String asset in assetsProject) {
      Future.value()
          .then((_) => rootBundle.load(asset))
          .then((value) => value.buffer.asUint8List())
          .then((value) {
        final image = Image.memory(
          value,
          fit: BoxFit.cover,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }

            return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: frame != null
                    ? SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: child,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ));
          },
        );
        precacheImage(image.image, context);
        images.add(BackgroundAnotacaoModel(widget: image, bytes: value));
      });
    }
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
    final usecase =
        ScreenInjection.of<AnotacaoInjection>(context).getFindAllConfigByModulo;
    final result = await usecase(FindAllConfigByModuloParams(modulo: "NOTE"));
    result.fold((left) => null, (right) => configs.addAll(right));
  }

  void save() async {
    final getSaveAnotacao =
        ScreenInjection.of<AnotacaoInjection>(context).getSaveAnotacao;

    Future.value()
        .then((_) => unfocus())
        .then((_) => _validateTitle())
        .then((result) {
      if (result) {
        showLoading(context);
        return true;
      } else {
        showMessage(context, "Preencha o título e tente novamente!");
      }

      return false;
    }).then((result) async {
      if (result) {
        anotacao.titulo = titleController.text;
        if (anotacao.id == null) {
          anotacao.data = DateTime.now();
        }
        anotacao.ultimaAtualizacao = DateTime.now();
        if (backgroundImage.value != null) {
          anotacao.imagemFundo =
              String.fromCharCodes(backgroundImage.value!.bytes!);
        } else {
          anotacao.imagemFundo = "";
        }
        anotacao.observacao = json.encode(
          quillController.document.toDelta().toJson()
        );
        anotacao.situacao =1;

        final response =
            await getSaveAnotacao(SaveAnotacaoParams(anotacao: anotacao));
        response.fold((left) {
          Navigator.of(context).pop();
          showMessage(
            context,
            "Não foi possível salvar os dados da anotação, tente novamente!"
          );
        }, (right) {
          Navigator.of(context).pop();
          showMessage(
            context,
            "Anotação ${isEdit ? 'atualizada' : 'cadastrada'} com sucesso"
          );
          if (!isEdit) {
            isEdit = true;
            anotacao.id = right.id;
          }
        });
      }
    });
  }

  bool _validateTitle() {
    if (titleController.text.isEmpty) {
      return false;
    }

    return true;
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
              style: TextButton.styleFrom(foregroundColor: color),
              child: const Text('Tirar uma foto',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              onPressed: () => Navigator.pop(ctx, MediaPickSetting.Camera),
            ),
            Container(height: 1.0, color: Colors.black),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: color),
              child: const Text('Gravar um vídeo',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
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
              style: TextButton.styleFrom(foregroundColor: color),
              child: const Text('Abrir da galeria',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              onPressed: () => Navigator.pop(ctx, MediaPickSetting.Gallery),
            ),
            Container(height: 1.0, color: Colors.black),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: color),
              child: const Text('Link',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              onPressed: () => Navigator.pop(ctx, MediaPickSetting.Link),
            ),
          ],
        ),
      ),
    );
  }

  void unfocus() {
    titleFocus.unfocus();
    editorFocus.unfocus();
  }

  void changeBackground(BackgroundAnotacaoModel? image) {
    if (backgroundImage.value != null) {
      backgroundImage.value!.isSelect = false;
    }

    backgroundImage.value = image;
    if (image != null) {
      backgroundImage.value!.isSelect = true;
    }
  }
}
