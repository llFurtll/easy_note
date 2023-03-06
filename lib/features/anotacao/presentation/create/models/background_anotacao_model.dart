import 'package:flutter/material.dart';

class BackgroundAnotacaoModel {
  final Widget widget;
  final String pathImage;
  bool isSelect;

  BackgroundAnotacaoModel({
    required this.widget,
    required this.pathImage,
    this.isSelect = false
  });
}