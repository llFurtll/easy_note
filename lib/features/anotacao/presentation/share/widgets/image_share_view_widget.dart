import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../controller/share_controller.dart';

class ImageShareViewWidget extends ScreenWidget<ShareController> {
  const ImageShareViewWidget({super.key});
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final args = controller.args;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: RepaintBoundary(
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          elevation: 10.0,
          child: Container(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 500.0,
            ),
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      args.anotacao.titulo!,
                      style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0
                    ),
                  ),
                ),
              ]
            )
          ),
        ),
      )
    );
  }
}