import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../../data/datasources/atualizacao_data_source.dart';
import '../../../../data/datasources/visualizacao_data_source.dart';
import '../../../../data/repositories/atualizacao_repository_impl.dart';
import '../../../../data/repositories/visualizacao_repository_impl.dart';
import '../../../../domain/usecases/get_find_atualizacao_by_versao.dart';
import '../../../../domain/usecases/get_save_visualizacao.dart';
import '../controller/novo_detalhe_controller.dart';

// ignore: must_be_immutable
class NovoDetalheInjection extends ScreenInjection<NovoDetalheController> {
  final getFindAtualizacaoByVersao = GetFindAtualizacaoByVersao(
      AtualizacaoRepositoryImpl(dataSource: AtualizacaoDataSourceImpl())
    );
  final getSaveVisualizacao = GetSaveVisualizacao(
    VisualizacaoRepositoryImpl(dataSource: VisualizacaoDataSourceImpl())
  );

  NovoDetalheInjection({
    super.key,
    required super.child
  }) : super(
    controller: NovoDetalheController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}