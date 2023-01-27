import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../../data/datasources/atualizacao_data_source.dart';
import '../../../data/datasources/versao_data_source.dart';
import '../../../data/repositories/atualizacao_repository_impl.dart';
import '../../../data/repositories/versao_repository_impl.dart';
import '../../../domain/usecases/get_existe_versao_without_view.dart';
import '../../../domain/usecases/get_find_last_versao.dart';
import '../controller/splash_controller.dart';

// ignore: must_be_immutable
class SplashInjection extends ScreenInjection<SplashController> {
  final getFindLastVersao = GetFindLastVersao(
    VersaoRepositoryImpl(dataSource: VersaoDataSourceImpl())
  );
  final getExisteVersaoWithoutView = GetExisteVersaoWithoutView(
    AtualizacaoRepositoryImpl(dataSource: AtualizacaoDataSourceImpl())
  );

  SplashInjection({
    super.key,
    required ScreenBridge child
  }) : super(
    controller: SplashController(),
    child: child
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}