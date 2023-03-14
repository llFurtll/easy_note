import 'package:screen_manager/screen_injection.dart';
import 'package:screen_manager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../../atualizacao/data/datasources/atualizacao_data_source.dart';
import '../../../atualizacao/data/repositories/atualizacao_repository_impl.dart';
import '../../../atualizacao/domain/usecases/get_existe_atualizacao_without_view.dart';
import '../../../versao/data/datasources/versao_data_source.dart';
import '../../../versao/data/repositories/versao_repository_impl.dart';
import '../../../versao/domain/usecases/get_find_last_versao.dart';
import '../controller/splash_controller.dart';

// ignore: must_be_immutable
class SplashInjection extends ScreenInjection<SplashController> {
  final getFindLastVersao = GetFindLastVersao(
    VersaoRepositoryImpl(dataSource: VersaoDataSourceImpl())
  );
  final getExisteAtualizacaoWithoutView = GetExisteAtualizacaoWithoutView(
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