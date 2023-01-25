import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecases/get_find_atualizacao_by_versao.dart';
import '../../../../domain/usecases/get_save_visualizacao.dart';
import '../controller/novo_detalhe_controller.dart';

// ignore: must_be_immutable
class NovoDetalheInjection extends ScreenInjection<NovoDetalheController> {
  final GetFindAtualizacaoByVersao getFindAtualizacaoByVersao;
  final GetSaveVisualizacao getSaveVisualizacao;

  NovoDetalheInjection({
    super.key,
    required super.child,
    required this.getFindAtualizacaoByVersao,
    required this.getSaveVisualizacao
  }) : super(
    controller: NovoDetalheController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}