import 'dart:typed_data';

import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../controller/anotacao_controller.dart';

// ignore: must_be_immutable
class ChangeImageAnotacaoViewWiget extends ScreenWidget<AnotacaoController> {
  const ChangeImageAnotacaoViewWiget({super.key});
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return BottomSheet(
      onClosing: () {},
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        )
      ),
      backgroundColor: Colors.grey.withOpacity(0.3),
      constraints: const BoxConstraints(
        minHeight: 200.0
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15.0, bottom: 15.0, top: 15.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: controller.images.map(
              (image) => _buildCard(image)
            ).toList(),
          ),
        );
      },
    );
  }

  Widget _buildCard(Uint8List bytes) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(right: 15.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      width: 120.0,
      height: 150.0,
      child: Image.memory(bytes, fit: BoxFit.cover),
    );
  }
}