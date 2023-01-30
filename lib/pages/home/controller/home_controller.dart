import 'package:compmanager/screen_controller.dart';
import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/show_message.dart';
import '../../../domain/entities/anotacao.dart';
import '../../../domain/usecases/get_find_all_anotacao.dart';
import '../../../domain/usecases/get_name_usuario.dart';
import '../../../domain/usecases/get_photo_usuario.dart';
import '../../../domain/usecases/get_save_name_usuario.dart';
import '../../configuracao/configuracao_list/view/configuracao_list_view.dart';
import '../../novo/novo_list/view/novo_list_view.dart';
import '../../sobre/view/sobre_view.dart';
import '../injection/home_injection.dart';
import '../widgets/alter_name_home_view_widget.dart';
import '../widgets/alter_photo_home_view_widget.dart';

class HomeController extends ScreenController {
  // CASOS DE USO
  late final GetFindAllAnotacao getFindAllAnotacao;
  late final GetNameUsuario getNameUsuario;
  late final GetSaveNameUsuario getSaveNameUsuario;
  late final GetPhotoUsuario getPhotoUsuario;

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

    Future.value()
      .then((_) => loadName())
      .then((result) {
        if (result == null ) {
          showMessage(context, "Erro ao tentar buscar o nome");
        } else {
          nameUser.value = result;
        }
      })
      .then((_) => loadPhoto())
      .then((result) {
        if (result == null) {
          showMessage(context, "Erro ao tentar buscar a foto");
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

  void saveName() async{
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

  Future<String?> loadPhoto() async {
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