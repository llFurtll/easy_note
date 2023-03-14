import 'package:screen_manager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../../visualizacao/data/datasources/visualizacao_data_source.dart';
import '../../../../visualizacao/data/repositories/visualizacao_repository_impl.dart';
import '../../../../visualizacao/domain/usecases/get_save_visualizacao.dart';
import '../../../data/datasources/atualizacao_data_source.dart';
import '../../../data/repositories/atualizacao_repository_impl.dart';
import '../../../domain/usecases/get_find_atualizacao_by_versao.dart';
import '../controller/atualizacao_detalhe_controller.dart';

// ignore: must_be_immutable
class AtualizacaoDetalheInjection extends ScreenInjection<AtualizacaoDetalheController> {
  final getFindAtualizacaoByVersao = GetFindAtualizacaoByVersao(
      AtualizacaoRepositoryImpl(dataSource: AtualizacaoDataSourceImpl())
    );
  final getSaveVisualizacao = GetSaveVisualizacao(
    VisualizacaoRepositoryImpl(dataSource: VisualizacaoDataSourceImpl())
  );

  AtualizacaoDetalheInjection({
    super.key,
    required super.child
  }) : super(
    controller: AtualizacaoDetalheController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}