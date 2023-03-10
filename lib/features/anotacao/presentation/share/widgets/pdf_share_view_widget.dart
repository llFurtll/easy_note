import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../controller/share_controller.dart';

class PdfShareViewWidget extends ScreenWidget<ShareController> {
  const PdfShareViewWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PDFView();
  }
}