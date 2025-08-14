import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart' as qx;
import 'package:intl/intl.dart';
import 'package:screen_manager/screen_controller.dart';
import 'package:screen_manager/screen_injection.dart';
import 'package:screen_manager/screen_mediator.dart';

import '../../../../../core/adapters/date_time_picker_easy_note.dart';
import '../../../../../core/adapters/image_picker_easy_note.dart';
import '../../../../../core/adapters/notification_easy_note.dart';
import '../../../../../core/adapters/shared_preferences_easy_note.dart';
import '../../../../../core/adapters/speech_text_easy_note.dart';
import '../../../../../core/arguments/share_anotacao_arguments.dart';
import '../../../../../core/enum/type_share.dart';
import '../../../../../core/utils/debounce.dart';
import '../../../../../core/utils/get_file.dart';
import '../../../../../core/utils/save_file.dart';
import '../../../../../core/widgets/custom_dialog.dart';
import '../../../../../core/widgets/show_loading.dart';
import '../../../../configuracao/domain/usecases/get_find_all_config_by_modulo.dart';
import '../../../domain/entities/anotacao.dart';
import '../../../domain/usecases/get_find_by_id_anotacao.dart';
import '../../../domain/usecases/get_save_anotacao.dart';
import '../../share/view/share_view.dart';
import '../injection/anotacao_injection.dart';
import '../models/background_anotacao_model.dart';
import '../widgets/mic_anotacao_view_widget.dart';

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
  final imagePicker = ImagePickerEasyNoteImpl();
  final speech = SpeechTextEasyNoteImpl();
  final isListen = ValueNotifier(false);
  final _notification = NotificationEasyNoteImpl();
  final datePicker = DateTimePickerEasyNoteImpl();
  final _shared = SharedPreferencesEasyNoteImpl();
  final _debounce = Debounce(milliseconds: 500);

  late final Timer timer;
  late final QuillController quillController;
  
  FormAnotacao formAnotacao = FormAnotacao();
  bool available = false;
  String textMic = "";
  DateTime? dataAgendamento;

  @override
  void onInit() {
    super.onInit();

    timer = Timer.periodic(
      const Duration(milliseconds: 500), (timer) => _showToolbarObserver()
    );

    final idAnotacao = ModalRoute.of(context)!.settings.arguments as int?;
    if (idAnotacao != null) {
      isEdit.value = true;
    }

    Future.value()
      .then((_) => _initMic())
      .then((_) => _loadConfigs())
      .then((_) => _loadImages())
      .then((_) => _loadAnotacao(idAnotacao))
      .then((_) => Future.delayed(const Duration(milliseconds: 500)))
      .then((_) => isLoading.value = false);
  }

  Future<void> _initMic() async {
    available = await speech.init();
  }

  Future<void> _loadAnotacao(int? idAnotacao) async {
    final injector = ScreenInjection.of<AnotacaoInjection>(context);

    if (idAnotacao == null) {
      quillController = QuillController.basic();
      return;
    }

    final ultimoAgendamento = _shared.getString(identity: "anotacao-$idAnotacao");
    if (ultimoAgendamento != null) {
      final date = DateTime.tryParse(ultimoAgendamento);
      if (date != null && date.isAfter(DateTime.now())) {
        dataAgendamento = date;
      }
    }

    final either = await injector
        .getFindByIdAnotacao(FindByIdAnotacaoParams(idAnotacao: idAnotacao));

    final response = either.fold((_) => null, (r) => r);

    if (response != null) {
      formAnotacao = FormAnotacao.fromAnotacao(response);
      titleController.text = formAnotacao.titulo ?? "";

      if (formAnotacao.observacao?.isNotEmpty == true) {
        quillController = QuillController(
          document: Document.fromJson(jsonDecode(formAnotacao.observacao!)),
          selection: const TextSelection.collapsed(offset: 0),
        );
      }

      if (formAnotacao.imagemFundo?.isNotEmpty == true) {
        // Não usa context aqui
        changeBackground(
          images.firstWhere(
            (item) => item.pathImage == formAnotacao.imagemFundo,
            orElse: () => BackgroundAnotacaoModel(widget: const SizedBox(), pathImage: "", isSelect: false),
          ),
        );
      }

      ultimaAtualizacao.value =
          "Atualizado em: ${DateFormat("dd/MM/yyyy HH:mm:ss").format(formAnotacao.ultimaAtualizacao!)}";
    }

    if (showConfig("AUTOSAVE")) {
      quillController.changes.listen((_) => _debounce.run(autoSave));
    }
  }

  void _loadImages() async {
    final navigator = Navigator.of(context);

    // Adiciona ícone da câmera (sincrono)
    images.add(
      BackgroundAnotacaoModel(
        widget: Center(
          child: IconButton(
            onPressed: changePhoto,
            icon: const Icon(Icons.camera, color: Colors.white, size: 40.0),
          ),
        ),
        pathImage: "",
        isSelect: false,
      ),
    );

    final dir = await getDir("anotacao/fundo");
    final list = dir?.listSync() ?? <FileSystemEntity>[];

    if (list.isNotEmpty) {
      for (final file in list) {
        if (file is! File) continue;

        final image = Image.file(
          file,
          fit: BoxFit.cover,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: frame != null
                  ? SizedBox(width: double.infinity, height: double.infinity, child: child)
                  : const Center(child: CircularProgressIndicator()),
            );
          },
        );

        // checa se a tela ainda está montada antes de usar um context
        if (!navigator.mounted) return;
        await precacheImage(image.image, navigator.context);

        images.add(BackgroundAnotacaoModel(widget: image, pathImage: file.path));
      }
    }

    if (showConfig("SHOWIMAGEAPP")) {
      final manifest = await rootBundle.loadString("AssetManifest.json");
      final Map<String, dynamic> manifestMap = json.decode(manifest);

      final assetsProject = manifestMap.keys
          .where((k) => k.contains("lib/assets/images/anotacao"))
          .where((k) => k.contains("thumbnail"))
          .toList();

      for (final asset in assetsProject) {
        final image = Image.asset(
          asset,
          fit: BoxFit.fill,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: frame != null
                  ? SizedBox(width: double.infinity, height: double.infinity, child: child)
                  : const Center(child: CircularProgressIndicator()),
            );
          },
        );

        if (!navigator.mounted) return;
        await precacheImage(image.image, navigator.context);

        if (asset.contains("thumbnail")) {
          images.add(
            BackgroundAnotacaoModel(
              widget: image,
              pathImage: asset.replaceAll("-thumbnail", ""),
            ),
          );
        }
      }
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
    _debounce.dispose();
    super.onClose();
  }

  void _loadConfigs() async {
    final usecase =
      ScreenInjection.of<AnotacaoInjection>(context).getFindAllConfigByModulo;
    var result = await usecase(FindAllConfigByModuloParams(modulo: "NOTE"));
    result.fold((left) => null, (right) => configs.addAll(right));
    result = await usecase(FindAllConfigByModuloParams(modulo: "APP"));
    result.fold((left) => null, (right) => configs.addAll(right));
  }

  void autoSave() {
    _debounce.run(() => save());
  }

  void save() async {
    final navigator = Navigator.of(context); // captura antes do gap
    final autoSave = showConfig("AUTOSAVE");

    final getSaveAnotacao =
      ScreenInjection.of<AnotacaoInjection>(context).getSaveAnotacao;

    Future.value()
      .then((_) => autoSave ? null : unfocus())
      .then((_) => _validateTitle())
      .then((result) {
        if (result) {
          if (!autoSave) {
            if (context.mounted) {
              showLoading(context);
            }
          }
          return true;
        } else {
          if (!autoSave) {
            if (context.mounted) {
              CustomDialog.warning("Preencha o título e tente novamente!", context);
            }
          }
        }
        return false;
      })
      .then((result) async {
        if (result) {
          formAnotacao.titulo = titleController.text;
          formAnotacao.ultimaAtualizacao = DateTime.now();
          String pathImage = formAnotacao.imagemFundo ?? "";
          if (pathImage.isNotEmpty) {
            if (pathImage.contains("cache")) {
              pathImage = await saveFile(pathImage, "anotacao/fundo");
              formAnotacao.imagemFundo = pathImage;
            }
          } else {
            formAnotacao.imagemFundo = "";
          }
          formAnotacao.observacao =
              json.encode(quillController.document.toDelta().toJson());
          formAnotacao.situacao = 1;

          final response = await getSaveAnotacao(
              SaveAnotacaoParams(anotacao: formAnotacao.toAnotacao()));
          response.fold((left) {
            navigator.pop();
            CustomDialog.error(
              "Não foi possível salvar os dados da anotação, tente novamente!",
              context,
            );
          }, (right) async {
            if (!autoSave) {
              navigator.pop();
            }
            ultimaAtualizacao.value =
                "Atualizado em: ${DateFormat("dd/MM/yyyy HH:mm:ss").format(formAnotacao.ultimaAtualizacao!)}";
            if (!autoSave) {
              CustomDialog.success(
                "Anotação ${isEdit.value ? 'atualizada' : 'cadastrada'} com sucesso",
                context,
              );
            }

            if (!isEdit.value) {
              isEdit.value = true;
              formAnotacao.id = right.id;
            }

            if (dataAgendamento != null) {
              String? ultimaData =
                  _shared.getString(identity: "anotacao-${formAnotacao.id}");
              if (ultimaData != null) {
                final dataFormat = DateTime.tryParse(ultimaData);
                if (dataFormat != null && dataFormat != dataAgendamento) {
                  await _notification.cancelNotification(id: formAnotacao.id!);
                }
              }
              await _shared.setValue(
                identity: "anotacao-${formAnotacao.id}",
                value: dataAgendamento!.toIso8601String(),
              );
              await _notification.createNotification(
                id: formAnotacao.id!,
                dateTime: dataAgendamento!,
                anotacao: formAnotacao.toAnotacao(),
              );
            } else {
              await _notification.cancelNotification(id: formAnotacao.id!);
              await _shared.remove(identity: "anotacao-${formAnotacao.id}");
            }

            ScreenMediator.callScreen("Home", "update", null);
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

  Future<qx.CameraAction?> selectCameraPickSetting(BuildContext context) {
    final navigator = Navigator.of(context);
    final color = Theme.of(context).primaryColor.withValues(alpha: 0.5);

    return showDialog<qx.CameraAction>(
      context: context,
      builder: (ctx) => CustomDialog(
        type: CustomDialogEnum.options,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: color),
              child: const Text(
                'Tirar uma foto',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: () => navigator.pop(qx.CameraAction.image),
            ),
            Container(height: 1.0, color: Colors.black),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: color),
              child: const Text(
                'Gravar um vídeo',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: () => navigator.pop(qx.CameraAction.video),
            ),
          ],
        ),
      ),
    );
  }

  Future<qx.InsertImageSource?> selectMediaPickSetting(BuildContext context) {
    final navigator = Navigator.of(context);
    final color = Theme.of(context).primaryColor.withValues(alpha: 0.5);

    return showDialog<qx.InsertImageSource>(
      context: context,
      builder: (ctx) => CustomDialog(
        type: CustomDialogEnum.options,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: color),
              child: const Text(
                'Abrir da galeria',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: () => navigator.pop(qx.InsertImageSource.gallery),
            ),
            Container(height: 1.0, color: Colors.black),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: color),
              child: const Text(
                'Link',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: () => navigator.pop(qx.InsertImageSource.link),
            ),
          ],
        ),
      ),
    );
  }

  void changePhoto() async {
    final navigator = Navigator.of(context);
    final color = Theme.of(context).primaryColor.withValues(alpha: 0.5);

    Future.value()
        .then((_) => showDialog<String>(
              barrierDismissible: false,
              // ignore: use_build_context_synchronously
              context: context,
              builder: (ctx) => CustomDialog(
                type: CustomDialogEnum.options,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(foregroundColor: color),
                      child: const Text(
                        'Tirar foto',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      onPressed: () => navigator.pop("camera"),
                    ),
                    Container(height: 1.0, color: Colors.black),
                    TextButton(
                      style: TextButton.styleFrom(foregroundColor: color),
                      child: const Text(
                        'Abrir da galeria',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      onPressed: () => navigator.pop("galeria"),
                    ),
                  ],
                ),
              ),
            ))
        .then((response) async {
          if (context.mounted) {
            showLoading(context);
          }
          if (response != null) {
            if (response == "galeria") {
              return imagePicker.getImage(ImagePickerEasyNoteOptions.gallery);
            }
            return imagePicker.getImage(ImagePickerEasyNoteOptions.camera);
          }
          return null;
        })
        .then((response) {
          navigator.pop(); // fecha loading
          if (response != null) {
            changeBackground(
              BackgroundAnotacaoModel(
                widget: Image.file(
                  File(response),
                  fit: BoxFit.cover,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
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
                            ),
                    );
                  },
                ),
                pathImage: response,
              ),
            );

            navigator.pop(); // fecha o dialog de opções se ainda aberto
          }
        });
  }

  void showMic() async {
    unfocus();
    
    if (!available) {
      CustomDialog.warning(
        "O EasyNote precisa da permissão "
        "do microfone do dispositivo para realizar essa operação.",
        context,
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (ctx) => const MicAnotacaoViewWidget(),
    );
  }

  void onListen() async {
    isListen.value = true;
    await speech.start((value) {
      textMic = value;
    });
  }

  void onCancelListen() {
    final navigator = Navigator.of(context);
    Future.value()
        .then((_) => isListen.value = false)
        .then((value) => Future.delayed(const Duration(seconds: 1)))
        .then((_) => navigator.pop())
        .then((_) {
          final end = quillController.document.length;
          final selection = TextSelection.collapsed(offset: end + textMic.length);
          quillController.replaceText(
            end,
            0,
            textMic,
            selection,
          );
        })
        .then((_) => textMic = "");
  }

  void share(TypeShare modo) async {
    final navigator = Navigator.of(context);
    late bool showImage;
    if (backgroundImage.value != null) {
      showImage = await showDialog<bool>(
            barrierDismissible: false,
            context: context,
            builder: (ctx) => CustomDialog(
              type: CustomDialogEnum.options,
              content: const Text(
                "Deseja compartilhar a anotação com a imagem de fundo?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () => navigator.pop(false),
                  child: const Text(
                    "Não",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                TextButton(
                  style:
                      TextButton.styleFrom(foregroundColor: Colors.greenAccent),
                  onPressed: () => navigator.pop(true),
                  child: const Text(
                    "Sim",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ) ??
          false;
    } else {
      showImage = false;
    }

    final arguments = ShareAnotacaoArguments(
      anotacao: formAnotacao.toAnotacao(),
      showImage: showImage,
      typeShare: modo,
    );

    Future.value().then(
      (_) => navigator.pushNamed(Share.routeShare, arguments: arguments),
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
      formAnotacao.imagemFundo = backgroundImage.value!.pathImage;
    } else {
      formAnotacao.imagemFundo = "";
    }

    if (showConfig("AUTOSAVE")) {
      autoSave();
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
    this.ultimaAtualizacao,
  }) {
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
      ultimaAtualizacao: anotacao.ultimaAtualizacao,
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
