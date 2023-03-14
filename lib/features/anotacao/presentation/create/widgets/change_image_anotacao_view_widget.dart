import 'package:screen_manager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../controller/anotacao_controller.dart';
import '../models/background_anotacao_model.dart';

// ignore: must_be_immutable
class ChangeImageAnotacaoViewWiget extends ScreenWidget<AnotacaoController> {
  const ChangeImageAnotacaoViewWiget({super.key});
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5.0),
          child: const Icon(Icons.drag_handle, color: Colors.grey, size: 40.0),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: controller.images.map(
              (image) => _buildCard(image)
            ).toList(),
          ),
        ),
      ]
    );
  }

  Widget _buildCard(BackgroundAnotacaoModel image) {
    return GestureDetector(
      onTap: image.pathImage.isEmpty ?
        null :
        () => controller.changeBackground(image),
      child: ValueListenableBuilder(
        valueListenable: controller.backgroundImage,
        builder: (context, value, child) {
          if (image.pathImage.isEmpty) {
            return Container(
              margin: const EdgeInsets.only(right: 15.0),
              width: 120.0,
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey,
              ),
              child: image.widget
            );
          }

          return Container(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.only(right: 15.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              color: Colors.white,
              border: image.isSelect ? Border.all(
                color: Colors.blueAccent, width: 10.0
              ) : null
            ),
            width: 120.0,
            height: 150.0,
            child: image.widget
          );
        },
      ),
    );
  }
}