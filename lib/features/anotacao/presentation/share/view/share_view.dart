import 'package:compmanager/screen_view.dart';
import 'package:flutter/material.dart';

import '../../../../../core/enum/type_share.dart';
import '../controller/share_controller.dart';
import '../injection/share_injection.dart';
import '../widgets/appbar_share_view_widget.dart';
import '../widgets/image_share_view_widget.dart';

class Share extends Screen {
  static const routeShare = "/share";

  const Share({super.key});

  @override
  ShareInjection build(BuildContext context) {
    return ShareInjection(
      child: const ScreenBridge<ShareController, ShareInjection>(
        child: ShareView()
      )
    );
  }
}

class ShareView extends ScreenView<ShareController> {
  const ShareView({super.key});

  @override
  Widget build(BuildContext context) {
    final isImage = TypeShare.isImage(controller.args.typeShare);

    return ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (context, value, child) {
        if (value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: const AppBarShareViewWidget(),
          body: isImage ? const ImageShareViewWidget() : Container(),
        );
      },
    );
  }
}