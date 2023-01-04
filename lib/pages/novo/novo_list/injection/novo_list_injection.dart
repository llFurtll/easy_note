import 'package:compmanager/screen_injection.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecases/get_find_all_versao.dart';
import '../controller/novo_list_controller.dart';

// ignore: must_be_immutable
class NovoListInjection extends ScreenInjection<NovoListController> {
  final GetFindAllVersao getFindAllVersao;

  NovoListInjection({
    super.key,
    required super.child,
    required this.getFindAllVersao
  }) : super(
    controller: NovoListController()
  );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}