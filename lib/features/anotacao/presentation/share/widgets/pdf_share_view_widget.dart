import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../../../core/widgets/custom_dialog.dart';
import '../controller/share_controller.dart';

class PdfShareViewWidget extends ScreenWidget<ShareController> {
  const PdfShareViewWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        elevation: 10.0,
        child: PDFView(
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: false,
          filePath: controller.pathPdf,
          onError: (error) {
            CustomDialog.error(
              "Não foi possível gerar o pdf, tente novamente!",
              context
            );
          },
        ),
      ),
    );
  }
}