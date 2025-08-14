import 'package:screen_manager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../data/datasources/configuracao_data_source.dart';
import '../../../data/repositories/configuracao_repository_impl.dart';
import '../../../domain/usecases/get_find_all_config_by_modulo.dart';
import '../../../domain/usecases/get_save_configuracao.dart';
import '../controller/configuracao_edit_controller.dart';

// ignore: must_be_immutable
class ConfiguracaoEditInjection extends ScreenInjection<ConfiguracaoEditController> {
  static final _configuracaoRepository = ConfiguracaoRepositoryImpl(
    dataSource: ConfiguracaoDataSourceImpl()
  );

  final GetFindAllConfigByModulo getFindAllConfigByModulo = GetFindAllConfigByModulo(_configuracaoRepository);
  final GetSaveConfiguracao getSaveConfiguracao = GetSaveConfiguracao(_configuracaoRepository);

  ConfiguracaoEditInjection({
    required super.child,
    super.key
  }) : super(
    controller: ConfiguracaoEditController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}