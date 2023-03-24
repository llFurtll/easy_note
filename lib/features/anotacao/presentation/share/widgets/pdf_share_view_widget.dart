import 'package:screen_manager/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../../../core/widgets/custom_dialog.dart';
import '../controller/share_controller.dart';

class PdfShareViewWidget extends ScreenWidget<ShareController> {
  const PdfShareViewWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PDFView(
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
    );
  }
}