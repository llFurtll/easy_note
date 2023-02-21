import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_receive.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../anotacao/data/datasources/anotacao_data_source.dart';
import '../../anotacao/data/repositories/anotacao_repository_impl.dart';
import '../../anotacao/domain/usecases/get_find_all_anotacao.dart';
import '../../usuario/data/datasources/usuario_data_source.dart';
import '../../usuario/data/repositories/usuario_repository_impl.dart';
import '../../usuario/domain/usecases/get_name_usuario.dart';
import '../../usuario/domain/usecases/get_photo_usuario.dart';
import '../../usuario/domain/usecases/get_save_name_usuario.dart';
import '../../usuario/domain/usecases/get_save_photo_usuario.dart';
import '../controller/home_controller.dart';

// ignore: must_be_immutable
class HomeInjection extends ScreenInjection<HomeController> {
  static final _usuarioRepository = UsuarioRepositoryImpl(
    dataSource: UsuarioDataSourceImpl()
  );

  final getFindAllAnotacao = GetFindAllAnotacao(
    AnotacaoRepositoryImpl(dataSource: AnotacaoDataSourceImpl())
  );
  final getNameUsuario = GetNameUsuario(_usuarioRepository);
  final getSaveNameUsuario = GetSaveNameUsuario(_usuarioRepository);
  final getPhotoUsuario = GetPhotoUsuario(_usuarioRepository);
  final getSavePhotoUsuario = GetSavePhotoUsuario(_usuarioRepository);

  HomeInjection({
    super.key,
    required ScreenBridge child
  }) : super(
    child: child,
    controller: HomeController(),
    receiveArgs: const ScreenReceiveArgs(receive: true, identity: "Home")
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}