import 'package:compmanager/screen_widget.dart';
import 'package:easy_note/core/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

import '../controller/home_controller.dart';

class AlterPhotoHomeViewWidget extends ScreenWidget<HomeController> {
  const AlterPhotoHomeViewWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final color = Theme.of(context).primaryColor.withOpacity(0.5);

    return ValueListenableBuilder(
      valueListenable: controller.photoUser,
      builder: (context, value, child) {
        final removeOption = value.isEmpty;

        return CustomDialog(
          type: CustomDialogEnum.options,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: color
                ),
                onPressed: controller.fromGallery,
                child: const Text(
                  "Abrir da galeria",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  )
                ),
              ),
              Container(height: 1.0, color: Colors.black),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: color
                ),
                onPressed: controller.fromCamera,
                child: const Text(
                  "Tirar foto",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  )
                ),
              ),
              !removeOption ? Container(height: 1.0, color: Colors.black) : Container(),
              !removeOption ?
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: color
                  ),
                  onPressed: !removeOption ? controller.removePhoto : null,
                  child: const Text(
                    "Remover foto",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    )
                  ),
                ) :
                Container()
            ],
          )
        );
      },
    );
  }
}