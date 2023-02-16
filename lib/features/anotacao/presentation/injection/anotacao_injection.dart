import 'package:compmanager/screen_injection.dart';
import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../../configuracao/data/datasources/configuracao_data_source.dart';
import '../../../configuracao/data/repositories/configuracao_repository_impl.dart';
import '../../../configuracao/domain/usecases/get_find_all_config_by_modulo.dart';
import '../../data/datasources/anotacao_data_source.dart';
import '../../data/repositories/anotacao_repository_impl.dart';
import '../../domain/usecases/get_save_anotacao.dart';
import '../controller/anotacao_controller.dart';

class AnotacaoInjection extends ScreenInjection<AnotacaoController> {
  final getFindAllConfigByModulo = GetFindAllConfigByModulo(
    ConfiguracaoRepositoryImpl(dataSource: ConfiguracaoDataSourceImpl())
  );
  final getSaveAnotacao = GetSaveAnotacao(
    AnotacaoRepositoryImpl(dataSource: AnotacaoDataSourceImpl())
  );

  AnotacaoInjection({
    super.key,
    required ScreenBridge child
  }) : super(
    child: child,
    controller: AnotacaoController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}