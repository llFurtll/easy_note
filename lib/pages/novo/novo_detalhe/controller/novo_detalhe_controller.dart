import 'package:compmanager/screen_controller.dart';
import 'package:flutter/material.dart';

class NovoDetalheController extends ScreenController {
  final pageViewController = PageController();
  final currentPage = ValueNotifier(0);
}