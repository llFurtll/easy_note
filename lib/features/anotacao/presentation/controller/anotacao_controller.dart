import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_mediator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/embeds/embed_types.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/save_file.dart';
import '../../../../core/widgets/custom_dialog.dart';
import '../../../../core/widgets/show_loading.dart';
import '../../../configuracao/domain/usecases/get_find_all_config_by_modulo.dart';
import '../../domain/entities/anotacao.dart';
import '../../domain/usecases/get_find_by_id_anotacao.dart';
import '../../domain/usecases/get_save_anotacao.dart';
import '../injection/anotacao_injection.dart';
import '../models/background_anotacao_model.dart';

class AnotacaoController extends ScreenController {
  final showIcones = ValueNotifier(false);
  final locale = const Locale("pt", "BR");
  final showToolbar = ValueNotifier(false);
  final titleFocus = FocusNode();
  final titleController = TextEditingController();
  final editorFocus = FocusNode();
  final isLoading = ValueNotifier(true);
  final configs = <String, int>{};
  final images = <BackgroundAnotacaoModel>[];
  final backgroundImage = ValueNotifier<BackgroundAnotacaoModel?>(null);
  final isEdit = ValueNotifier(false);
  final ultimaAtualizacao = ValueNotifier<String?>(null);

  late final Timer timer;
  late final QuillController quillController;
  
  FormAnotacao formAnotacao = FormAnotacao();

  @override
  void onInit() {
    super.onInit();

    timer = Timer.periodic(
        const Duration(milliseconds: 500), (timer) => _showToolbarObserver());

    final idAnotacao = ModalRoute.of(context)!.settings.arguments as int?;
    if (idAnotacao != null) {
      isEdit.value = true;
    }

    Future.value()
      .then((_) => _loadConfigs())
      .then((_) => _loadImages())
      .then((_) => _loadAnotacao(idAnotacao))
      .then((_) => Future.delayed(const Duration(milliseconds: 500)))
      .then((_) => isLoading.value = false);
  }

  void _loadAnotacao(int? idAnotacao) async {
    if (idAnotacao == null) {
      quillController = QuillController.basic();
      return;
    }

    final getFindById =
      ScreenInjection.of<AnotacaoInjection>(context).getFindByIdAnotacao;

    Future.value()
      .then((_) => getFindById(FindByIdAnotacaoParams(idAnotacao: idAnotacao)))
      .then((response) => response.fold((left) => null, (right) => right))
      .then((response) {
        if (response != null) {
          formAnotacao = FormAnotacao.fromAnotacao(response);
          titleController.text = formAnotacao.titulo ?? "";
          if (formAnotacao.observacao != null &&
              formAnotacao.observacao!.isNotEmpty) {
            quillController = QuillController(
                document: Document.fromJson(jsonDecode(formAnotacao.observacao!)),
                selection: const TextSelection.collapsed(offset: 0));
          }
          if (formAnotacao.imagemFundo != null &&
              formAnotacao.imagemFundo!.isNotEmpty) {
            backgroundImage.value = images.firstWhere(
              (item) => item.pathImage == formAnotacao.imagemFundo
            );
          }
          ultimaAtualizacao.value =
            "Última atualização às: ${DateFormat("dd/MM/yyyy HH:mm:ss")
            .format(formAnotacao.ultimaAtualizacao!
          )}";
        }
    });
  }

  void _loadImages() async {
    final manifest = await rootBundle.loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifest);

    final assetsProject = manifestMap.keys
      .where((key) => key.contains("lib/assets/images/anotacao"))
      .where((key) => key.contains(".jpg"))
      .toList();

    for (String asset in assetsProject) {
      Future.value()
        .then((_) {
          return Image.asset(
            asset,
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
        })
        .then((image) async {
          await precacheImage(image.image, context);
          images.add(BackgroundAnotacaoModel(widget: image, pathImage: asset));
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
          CustomDialog.warning("Preencha o título e tente novamente!", context);
        }

        return false;
      })
      .then((result) async {
        if (result) {
          formAnotacao.titulo = titleController.text;
          formAnotacao.ultimaAtualizacao = DateTime.now();
          if (backgroundImage.value != null) {
            formAnotacao.imagemFundo = backgroundImage.value!.pathImage;
          } else {
            formAnotacao.imagemFundo = "";
          }
          formAnotacao.observacao =
            json.encode(quillController.document.toDelta().toJson());
          formAnotacao.situacao = 1;

          final response = await getSaveAnotacao(
            SaveAnotacaoParams(anotacao: formAnotacao.toAnotacao()));
          response.fold((left) {
            Navigator.of(context).pop();
            CustomDialog.error(
              "Não foi possível salvar os dados da anotação, tente novamente!",
              context
            );
          }, (right) {
            Navigator.of(context).pop();
            ultimaAtualizacao.value =
              "Última atualização às: ${
              DateFormat("dd/MM/yyyy HH:mm:ss")
              .format(formAnotacao.ultimaAtualizacao!
            )}";
            CustomDialog.success(
              "Anotação ${isEdit.value ? 'atualizada' : 'cadastrada'} com sucesso",
              context
            );
            if (!isEdit.value) {
              isEdit.value = true;
              formAnotacao.id = right.id;
            }
            ScreenMediator.callScreen("Home")!.receive("update", null);
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
        type: CustomDialogEnum.options,
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
        type: CustomDialogEnum.options,
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

class FormAnotacao {
  int? id;
  String? titulo;
  DateTime? data;
  int? situacao;
  String? imagemFundo;
  String? observacao;
  DateTime? ultimaAtualizacao;

  FormAnotacao({
    this.id,
    this.titulo,
    this.situacao = 1,
    this.data,
    this.imagemFundo = "",
    this.observacao,
    this.ultimaAtualizacao}
  ) {
    data ??= DateTime.now();
  }

  factory FormAnotacao.fromAnotacao(Anotacao anotacao) {
    return FormAnotacao(
      id: anotacao.id,
      titulo: anotacao.titulo,
      data: anotacao.data,
      situacao: anotacao.situacao,
      imagemFundo: anotacao.imagemFundo,
      observacao: anotacao.observacao,
      ultimaAtualizacao: anotacao.ultimaAtualizacao
    );
  }

  Anotacao toAnotacao() {
    return Anotacao(
      id: id,
      titulo: titulo,
      situacao: situacao,
      data: data,
      imagemFundo: imagemFundo,
      observacao: observacao,
      ultimaAtualizacao: ultimaAtualizacao,
    );
  }
}
