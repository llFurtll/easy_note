import 'dart:typed_data';

import 'package:flutter/material.dart';

class BackgroundAnotacaoModel {
  final Widget widget;
  final Uint8List? bytes;
  bool isSelect;

  BackgroundAnotacaoModel({
    required this.widget,
    required this.bytes,
    this.isSelect = false
  });
}