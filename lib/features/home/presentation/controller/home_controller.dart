import 'package:flutter/material.dart';
import 'package:screen_manager/screen_controller.dart';
import 'package:screen_manager/screen_injection.dart';
import 'package:screen_manager/screen_receive.dart';

import '../../../../core/adapters/image_picker_easy_note.dart';
import '../../../../core/adapters/notification_easy_note.dart';
import '../../../../core/adapters/shared_preferences_easy_note.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/services/remove_tasks.dart';
import '../../../../core/utils/debounce.dart';
import '../../../../core/utils/delete_file.dart';
import '../../../../core/utils/save_file.dart';
import '../../../../core/widgets/custom_dialog.dart';
import '../../../../core/widgets/show_loading.dart';
import '../../../anotacao/domain/usecases/get_delete_anotacao.dart';
import '../../../anotacao/domain/usecases/get_find_all_anotacao.dart';
import '../../../anotacao/presentation/create/view/anotacao_view.dart';
import '../../../atualizacao/presentation/atualizacao_list/view/atualizacao_list_view.dart';
import '../../../configuracao/presentation/configuracao_list/view/configuracao_list_view.dart';
import '../../../sobre/presentation/view/sobre_view.dart';
import '../../../usuario/domain/usecases/get_name_usuario.dart';
import '../../../usuario/domain/usecases/get_photo_usuario.dart';
import '../../../usuario/domain/usecases/get_save_name_usuario.dart';
import '../../../usuario/domain/usecases/get_save_photo_usuario.dart';
import '../injection/home_injection.dart';
import '../models/list_item_note_home_model.dart';
import '../widgets/alter_name_home_view_widget.dart';
import '../widgets/alter_photo_home_view_widget.dart';
import '../widgets/delete_anotacao_view_widget.dart';

class HomeController extends ScreenController {
  // ADAPTERS
  final imagePicker = ImagePickerEasyNoteImpl();
  final shared = SharedPreferencesEasyNoteImpl();
  final _notification = NotificationEasyNoteImpl();

  // CASOS DE USO
  late final GetFindAllAnotacao getFindAllAnotacao;
  late final GetNameUsuario getNameUsuario;
  late final GetSaveNameUsuario getSaveNameUsuario;
  late final GetPhotoUsuario getPhotoUsuario;
  late final GetSavePhotoUsuario getSavePhotoUsuario;
  late final GetDeleteAnotacao getDeleteAnotacao;

  // VALUE NOTIFIER
  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  final ValueNotifier<bool> isLoadingList = ValueNotifier(false);
  final ValueNotifier<String> nameUser = ValueNotifier("");
  final ValueNotifier<String> photoUser = ValueNotifier("");

  // FOCUS
  final FocusNode focusNode = FocusNode();

  // CONTROLLERS
  final TextEditingController textController = TextEditingController();

  // KEYS
  GlobalKey<FormState> formKeyAlterName = GlobalKey();

  // VARIÁVEIS
  final List<ListItemNoteHomeModel> anotacoes = [];
  bool fotoPerfilCarregada = false;

  // DEBOUNCE
  final _debounce = Debounce(milliseconds: 500);

  // SERVICES
  final _removeTasks = RemoveTasks();

  @override
  void onInit() {
    super.onInit();

    getFindAllAnotacao =
      ScreenInjection.of<HomeInjection>(context).getFindAllAnotacao;
    getNameUsuario = ScreenInjection.of<HomeInjection>(context).getNameUsuario;
    getSaveNameUsuario =
      ScreenInjection.of<HomeInjection>(context).getSaveNameUsuario;
    getPhotoUsuario =
      ScreenInjection.of<HomeInjection>(context).getPhotoUsuario;
    getSavePhotoUsuario =
      ScreenInjection.of<HomeInjection>(context).getSavePhotoUsuario;
    getDeleteAnotacao =
      ScreenInjection.of<HomeInjection>(context).getDeleteAnotacao;

    Future.value()
      .then((_) => loadName())
      .then((result) {
        result.fold((left) {
          CustomDialog.error("Erro ao tentar buscar o nome!", context);
        }, (right) {
          if (right.isNotEmpty) {
            nameUser.value = right;
          }
        });
      })
      .then((_) => _loadPhoto())
      .then((result) {
        result.fold((left) {
          CustomDialog.error(
            "Erro ao tentar buscar a foto de perfil!", context
          );
        }, (right) {
          if (right.isNotEmpty) {
            photoUser.value = right;
          }
        });
      })
      .then((_) => loadAnotacoes(""))
      .then((_) => _notification.getPayload())
      .then((value) {
        if (value != null) {
          toEdit(int.parse(value));
        }
      })
      .then((_) => isLoading.value = false)
      .then((_) => Future.delayed(const Duration(seconds: 5)))
      .then((_) => _removeTasks.execute());
  }
  
  @override
  void onClose() {
    super.onClose();
    _debounce.dispose();
    _removeTasks.dispose();
  }
  
  Future<void> loadAnotacoes(String descricao) async {
    anotacoes.clear();
    final response =
      await getFindAllAnotacao(FindAllAnotacaoParams(descricao: descricao));
    response.fold((left) => null, (right) {
      if (right.isNotEmpty) {
        anotacoes
          .addAll(right.map((item) => ListItemNoteHomeModel.fromMap(item)));
      }
    });
  }

  Future<Result<Failure, String>> loadName() async {
    return await getNameUsuario(NameUsuarioParams(idUsuario: 1));
  }

  void saveName() {
    if (formKeyAlterName.currentState!.validate()) {
      formKeyAlterName.currentState!.save();

      Future.value()
        .then((_) async => await getSaveNameUsuario(
          SaveNameUsuarioParams(
            idUsuario: 1, name: nameUser.value)
          )
        )
        .then((result) {
          result.fold(
            (left) => null,
            (right) {
              if (right == 0) {
                CustomDialog.error(
                    "Erro ao atualizar o nome do usuário, tente novamente!",
                    context);
                nameUser.value = "";
              } else {
                Navigator.of(context).pop();
              }
            }
          );
        }
      );
    }
  }

  Future<Result<Failure, String>> _loadPhoto() async {
    return await getPhotoUsuario(PhotoUsuarioParams(idUsuario: 1));
  }

  void removeFocus() {
    focusNode.unfocus();
  }

  void showAlterName() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const AlterNameHomeViewWidget()
    );
  }

  void showAlterPhoto() {
    showDialog(
      context: context,
      builder: (context) => const AlterPhotoHomeViewWidget()
    );
  }

  void fromGallery() {
    Future.value()
      // ignore: use_build_context_synchronously
      .then((_) => Navigator.of(context).pop())
      // ignore: use_build_context_synchronously
      .then((_) => showLoading(context))
      .then((_) => imagePicker.getImage(ImagePickerEasyNoteOptions.gallery))
      .then((result) => _savePhotoUser(result))
      .then((result) {
        if (result.isNotEmpty) {
          photoUser.value = result;
        } else if (result == "0") {
          CustomDialog.error(
            "Não foi possível salvar a foto de perfil, tente novamente!",
            // ignore: use_build_context_synchronously
            context
          );
        }
      })
    // ignore: use_build_context_synchronously
    .then((_) => Navigator.of(context).pop());
  }

  void fromCamera() {
    Future.value()
      // ignore: use_build_context_synchronously
      .then((value) => Navigator.of(context).pop())
      // ignore: use_build_context_synchronously
      .then((_) => showLoading(context))
      .then((_) => imagePicker.getImage(ImagePickerEasyNoteOptions.camera))
      .then((result) => _savePhotoUser(result))
      .then((result) {
        if (result.isNotEmpty && result != "0") {
          fotoPerfilCarregada = false;
          photoUser.value = result;
        } else if (result == "0") {
          CustomDialog.error(
            "Não foi possível salvar a foto de perfil, tente novamente!",
            // ignore: use_build_context_synchronously
            context
          );
        }
      })
      // ignore: use_build_context_synchronously
      .then((_) => Navigator.of(context).pop());
  }

  Future<void> _deleteOldPhoto() async {
    final otherPhoto = await _loadPhoto();
    otherPhoto.fold((left) => null, (right) {
      if (right.isNotEmpty) {
        deleteFile(right);
      }
    });
  }

  Future<String> _savePhotoUser(String? path) async {
    if (path != null && path.isNotEmpty) {
      String subFolder = "perfil";
      final pathFile = await saveFile(path, subFolder);

      if (pathFile.isEmpty) {
        return "0";
      }

      await _deleteOldPhoto();
      final save = await getSavePhotoUsuario(
          SavePhotoUsuarioParams(idUsuario: 1, path: pathFile));

      return save.fold((left) => "", (right) async {
        if (right > 0) {
          return pathFile;
        } else {
          return "0";
        }
      });
    }

    return "";
  }

  Future<void> removePhoto() async {
    Future.value()
      // ignore: use_build_context_synchronously
      .then((_) => Navigator.of(context).pop())
      // ignore: use_build_context_synchronously
      .then((_) => showLoading(context))
      .then((_) => _deleteOldPhoto())
      .then((_) => getSavePhotoUsuario(
        SavePhotoUsuarioParams(idUsuario: 1, path: ""))
      )
      .then((result) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        result.fold((left) {
          CustomDialog.error(
            "Não foi possível remover a foto de perfil, tente novamente!",
            context
          );
        }, (right) {
          if (right > 0) {
            CustomDialog.success(
              "Foto de perfil removida com sucesso!",
              context
            );
            fotoPerfilCarregada = false;
            photoUser.value = "";
          } else {
            CustomDialog.error(
              "Não foi possível remover a foto de perfil, tente novamente!",
              context
            );
          }
        }
      );
    });
  }

  void removeAnotacao(ListItemNoteHomeModel item) async {
    final result = await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) =>
        DeleteAnotacaoViewWidget(titleAnotacao: item.titulo)
      );

    if (result!) {
      Future.value()
        // ignore: use_build_context_synchronously
        .then((_) => showLoading(context))
        .then((_) => getDeleteAnotacao(DeleteAnotacaoParams(idAnotacao: item.id)))
        .then((response) => response.fold((left) => null, (right) => right))
        .then((response) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          if (response == null) {
            CustomDialog.error(
              "Não foi possível deletar a anotação, tente novamente!",
              // ignore: use_build_context_synchronously
              context
            );

            return false;
          }

          CustomDialog.success(
            "Anotação deletada com sucesso!",
            // ignore: use_build_context_synchronously
            context
          );

          return true;
      })
      .then((value) async {
        if (value) {
          await shared.remove(identity: "anotacao-${item.id}");
          await _notification.cancelNotification(id: item.id);

          Future.value()
            .then((_) => isLoadingList.value = true)
            .then((_) => loadAnotacoes(""))
            .then((_) => isLoadingList.value = false);
        }
      });
    }
  }

  bool verifySize(BoxConstraints constraints) {
    var height = MediaQuery.of(context).padding.top;
    var top = constraints.biggest.height;
    if (top == height + kToolbarHeight) {
      return true;
    } else {
      return false;
    }
  }

  void toSobre() {
    Navigator.of(context).pushNamed(Sobre.routeSobre);
  }

  void toConfiguracao() {
    Navigator.of(context).pushNamed(ConfiguracaoList.routeConfig);
  }

  void toNovo() {
    Navigator.of(context).pushNamed(AtualizacaoList.routeAtualizacaoList);
  }

  void toEdit(int id) {
    Navigator.of(context)
        .pushNamed(AnotacaoScreen.routeAnotacao, arguments: id);
  }

  void onSearch(String text) {
    _debounce.run(() {
      Future.value()
        .then((_) => isLoadingList.value = true)
        .then((_) => loadAnotacoes(text))
        .then((_) => isLoadingList.value = false);
    });
  }

  Future<void> onRefresh() async {
    await Future.value()
      .then((_) => Future.delayed(const Duration(seconds: 1)))
      .then((_) => isLoadingList.value = true)
      .then((_) => loadAnotacoes(textController.text))
      .then((_) => isLoadingList.value = false);
  }

  void receive(String message, value, {ScreenReceive? screen}) async {
    switch (message) {
      case "update":
        Future.value()
          .then((_) => isLoadingList.value = true)
          .then((_) => loadAnotacoes(""))
          .then((_) => isLoadingList.value = false);
    }
  }
}
