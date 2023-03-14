import 'package:screen_manager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../../versao/data/datasources/versao_data_source.dart';
import '../../../../versao/data/repositories/versao_repository_impl.dart';
import '../../../../versao/domain/usecases/get_find_all_versao.dart';
import '../controller/atualizacao_list_controller.dart';

// ignore: must_be_immutable
class AtualizacaoListInjection extends ScreenInjection<AtualizacaoListController> {
  final getFindAllVersao = GetFindAllVersao(
    VersaoRepositoryImpl(dataSource: VersaoDataSourceImpl())
  );

  AtualizacaoListInjection({
    super.key,
    required super.child
  }) : super(
    controller: AtualizacaoListController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}