import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../../data/datasources/versao_data_source.dart';
import '../../../../data/repositories/versao_repository_impl.dart';
import '../../../../domain/usecases/get_find_all_versao.dart';
import '../controller/novo_list_controller.dart';

// ignore: must_be_immutable
class NovoListInjection extends ScreenInjection<NovoListController> {
  final getFindAllVersao = GetFindAllVersao(
    VersaoRepositoryImpl(dataSource: VersaoDataSourceImpl())
  );

  NovoListInjection({
    super.key,
    required super.child
  }) : super(
    controller: NovoListController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}