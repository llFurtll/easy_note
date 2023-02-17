import 'dart:typed_data';

import 'package:flutter/material.dart';

class BackgroundAnotacaoModel {
  final Widget widget;
  final Uint8List? bytes;
  final String pathImage;
  bool isSelect;

  BackgroundAnotacaoModel({
    required this.widget,
    required this.bytes,
    required this.pathImage,
    this.isSelect = false
  });
}