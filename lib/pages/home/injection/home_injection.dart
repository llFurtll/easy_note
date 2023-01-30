import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../../data/datasources/anotacao_data_source.dart';
import '../../../data/datasources/usuario_data_source.dart';
import '../../../data/repositories/anotacao_repository_impl.dart';
import '../../../data/repositories/usuario_repository_impl.dart';
import '../../../domain/usecases/get_find_all_anotacao.dart';
import '../../../domain/usecases/get_name_usuario.dart';
import '../../../domain/usecases/get_save_name_usuario.dart';
import '../controller/home_controller.dart';

// ignore: must_be_immutable
class HomeInjection extends ScreenInjection<HomeController> {
  static final _usuarioRepository = UsuarioRepositoryImpl(
    dataSource: UsuarioDataSourceImpl()
  );

  final GetFindAllAnotacao getFindAllAnotacao = GetFindAllAnotacao(
    AnotacaoRepositoryImpl(dataSource: AnotacaoDataSourceImpl())
  );
  final GetNameUsuario getNameUsuario = GetNameUsuario(_usuarioRepository);
  final GetSaveNameUsuario getSaveNameUsuario = GetSaveNameUsuario(_usuarioRepository);

  HomeInjection({
    super.key,
    required ScreenBridge child
  }) : super(
    child: child,
    controller: HomeController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}