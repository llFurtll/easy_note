import 'package:compmanager/screen_widget.dart';
import 'package:easy_note/features/anotacao/presentation/share/controller/share_controller.dart';
import 'package:flutter/material.dart';

class AppBarShareViewWidget extends ScreenWidget<ShareController>
  with PreferredSizeWidget {
  const AppBarShareViewWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text(
        "Compartilhar anotação",
        style: TextStyle(fontWeight: FontWeight.bold)
      ),
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios),
        tooltip: "Voltar",      
      ),
      actions: _buildActions(),
    );
  }
  
  List<Widget> _buildActions() {
    return [
      IconButton(
        onPressed: controller.share,
        icon: const Icon(Icons.share),
      ),
    ];
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}