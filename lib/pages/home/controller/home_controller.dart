import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../core/adapters/image_picker.dart';
import '../../../core/utils/delete_file.dart';
import '../../../core/utils/save_file.dart';
import '../../../core/widgets/show_loading.dart';
import '../../../core/widgets/show_message.dart';
import '../../../domain/entities/anotacao.dart';
import '../../../domain/usecases/get_find_all_anotacao.dart';
import '../../../domain/usecases/get_name_usuario.dart';
import '../../../domain/usecases/get_photo_usuario.dart';
import '../../../domain/usecases/get_save_name_usuario.dart';
import '../../../domain/usecases/get_save_photo_usuario.dart';
import '../../configuracao/configuracao_list/view/configuracao_list_view.dart';
import '../../novo/novo_list/view/novo_list_view.dart';
import '../../sobre/view/sobre_view.dart';
import '../injection/home_injection.dart';
import '../widgets/alter_name_home_view_widget.dart';
import '../widgets/alter_photo_home_view_widget.dart';

class HomeController extends ScreenController {
  // ADAPTERS
  final imagePicker = ImagePickerEasyNote();

  // CASOS DE USO
  late final GetFindAllAnotacao getFindAllAnotacao;
  late final GetNameUsuario getNameUsuario;
  late final GetSaveNameUsuario getSaveNameUsuario;
  late final GetPhotoUsuario getPhotoUsuario;
  late final GetSavePhotoUsuario getSavePhotoUsuario;

  // VALUE NOTIFIER
  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  final ValueNotifier<String> nameUser = ValueNotifier("");
  final ValueNotifier<String> photoUser = ValueNotifier("");

  // FOCUS
  final FocusNode focusNode = FocusNode();

  // CONTROLLERS
  final TextEditingController textController = TextEditingController();

  // KEYS
  GlobalKey<FormState> formKeyAlterName = GlobalKey();

  // VARIÁVEIS
  final List<Anotacao> anotacoes = [];

  @override
  void onInit() {
    super.onInit();

    getFindAllAnotacao = ScreenInjection.of<HomeInjection>(context).getFindAllAnotacao;
    getNameUsuario = ScreenInjection.of<HomeInjection>(context).getNameUsuario;
    getSaveNameUsuario = ScreenInjection.of<HomeInjection>(context).getSaveNameUsuario;
    getPhotoUsuario = ScreenInjection.of<HomeInjection>(context).getPhotoUsuario;
    getSavePhotoUsuario = ScreenInjection.of<HomeInjection>(context).getSavePhotoUsuario;

    Future.value()
      .then((_) => loadName())
      .then((result) {
        if (result == null) {
          showMessage(context, "Erro ao tentar buscar o nome!");
        } else {
          nameUser.value = result;
        }
      })
      .then((_) => _loadPhoto())
      .then((result) {
        if (result == null) {
          showMessage(context, "Erro ao tentar buscar a foto de perfil!");
        } else {
          photoUser.value = result;
        }
      })
      .then((_) => loadAnotacoes(""))
      .then((value) {
        if (value != null && value.isNotEmpty) {
          anotacoes.addAll(value);
        }
      })
      .then((_) => isLoading.value = false);
  }

  Future<List<Anotacao>?> loadAnotacoes(String descricao) async {
    return await getFindAllAnotacao(FindAllAnotacaoParams(descricao: descricao));
  }

  Future<String?> loadName() async {
    return await getNameUsuario(NameUsuarioParams(
      idUsuario: 1
    ));
  }

  void saveName(){
    if (formKeyAlterName.currentState!.validate()) {
      formKeyAlterName.currentState!.save();

      Future.value()
        .then((_) async => await getSaveNameUsuario(
          SaveNameUsuarioParams(
            idUsuario: 1,
            name: nameUser.value
          )
        ))
        .then((result) {
          if (result == null || result == 0) {
            showMessage(context, "Erro ao atualizar o nome do usuário, tente novamente!");
            nameUser.value = "";
          } else {
            Navigator.of(context).pop();
          }
        });
    }
  }

  Future<String?> _loadPhoto() async {
    return await getPhotoUsuario(PhotoUsuarioParams(
      idUsuario: 1
    ));
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
    showDialog(context: context, builder: (context) => const AlterPhotoHomeViewWidget());
  }

  void fromGallery() {
    Navigator.of(context).pop();

    Future.value()
      .then((_) => showLoading(context))
      .then((_) => imagePicker.getImage(ImagePickerEnum.gallery))
      .then((result) => _savePhotoUser(result))
      .then((result) {
        if (result.isNotEmpty) {
          photoUser.value = result;
        } else if (result == "-1" || result == "0") {
          showMessage(context, "Não foi possível salvar a foto de perfil, tente novamente!");
        }
      })
      .then((_) => Navigator.of(context).pop());
  }

  void fromCamera() {
    Navigator.of(context).pop();
    
    Future.value()
      .then((_) => showLoading(context))
      .then((_) => imagePicker.getImage(ImagePickerEnum.camera))
      .then((result) => _savePhotoUser(result))
      .then((result) {
        if (result.isNotEmpty) {
          photoUser.value = result;
        } else if (result == "-1" || result == "0") {
          showMessage(context, "Não foi possível salvar a foto de perfil, tente novamente!");
        }
      })
      .then((_) => Navigator.of(context).pop());
  }

  Future<void> _deleteOldPhoto() async {
    String? otherPhoto = await _loadPhoto();
    if (otherPhoto != null && otherPhoto.isNotEmpty) {
      deleteFile(otherPhoto);
    }
  }

  Future<bool> _saveFile(String pathFile, String path, String nomeFile) async {
    return await saveFile(pathFile, path, nomeFile);
  }

  Future<String> _savePhotoUser(String? path) async {
    if (path != null && path.isNotEmpty) {
      await _deleteOldPhoto();
      final extension = path.split(".").last;
      bool saveFile = await _saveFile(path, "perfil", "${DateTime.now().toIso8601String()}.$extension");

      if (!saveFile) {
        return "-1";
      }
      
      int? save = await getSavePhotoUsuario(SavePhotoUsuarioParams(
        idUsuario: 1,
        path: path
      ));

      if (save != null && save > 0) {
        return path;
      } else {
        return "0";
      }
    }

    return "";
  }

  Future<void> removePhoto() async {
    Navigator.of(context).pop();
    showLoading(context);

    await _deleteOldPhoto();

    Future.value()
      .then((_) => getSavePhotoUsuario(SavePhotoUsuarioParams(
        idUsuario: 1,
        path: ""
      )))
      .then((result) {
        Navigator.of(context).pop();
        if (result != null && result > 0) {
          photoUser.value = "";
          showMessage(context, "Foto de perfil removida com sucesso!");
        } else {
          showMessage(context, "Não foi possível remover a foto de perfil, tente novamente!");
        }
      });
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
    Navigator.of(context).pushNamed(NovoList.routeNovoList);
  }
}