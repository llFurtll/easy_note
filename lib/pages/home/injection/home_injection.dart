import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../../data/datasources/anotacao_data_source.dart';
import '../../../data/repositories/anotacao_repository_impl.dart';
import '../../../domain/usecases/get_find_all_anotacao.dart';
import '../controller/home_controller.dart';

// ignore: must_be_immutable
class HomeInjection extends ScreenInjection<HomeController> {
  final GetFindAllAnotacao getFindAllAnotacao = GetFindAllAnotacao(
    AnotacaoRepositoryImpl(dataSource: AnotacaoDataSourceImpl())
  );

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