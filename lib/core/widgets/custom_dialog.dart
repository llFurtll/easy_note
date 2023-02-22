import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

enum CustomDialogEnum { success, warning, error, options }

class CustomDialog extends StatelessWidget {
  final Widget content;
  final List<Widget>? actions;
  final CustomDialogEnum type;

  const CustomDialog(
      {super.key,
      required this.content,
      this.actions,
      this.type = CustomDialogEnum.success});

  @override
  Widget build(BuildContext context) {
    final colors = _getColor();
    final icon = _getIcon();

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
          color: colors.item1,
        ),
        height: 120.0,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.item2,
            ),
            width: 80.0,
            height: 80.0,
            child: Icon(icon, size: 30.0, color: Colors.white),
          ),
        ),
      ),
      content: content,
      actions: actions,
    );
  }

  Tuple2<Color, Color> _getColor() {
    switch (type) {
      case CustomDialogEnum.success:
        return Tuple2(Colors.green, Colors.green.shade300);
      case CustomDialogEnum.warning:
        return Tuple2(Colors.orangeAccent, Colors.orangeAccent.shade100);
      case CustomDialogEnum.error:
        return const Tuple2(Colors.red, Colors.redAccent);
      case CustomDialogEnum.options:
        return Tuple2(Colors.blueAccent, Colors.blueAccent.shade100);
    }
  }

  IconData _getIcon() {
    switch (type) {
      case CustomDialogEnum.success:
        return Icons.check;
      case CustomDialogEnum.warning:
        return Icons.warning;
      case CustomDialogEnum.error:
        return Icons.close;
      case CustomDialogEnum.options:
        return Icons.lightbulb;
    }
  }

  static void success(String message, BuildContext context) {
    showDialog(context: context, builder: (context) {
      return CustomDialog(
        type: CustomDialogEnum.success,
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.greenAccent
            ),
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              "Sair",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green
              )
            ),
          ),
        ],
      ); 
    });
  }

  static void warning(String message, BuildContext context) {
    showDialog(context: context, builder: (context) {
      return CustomDialog(
        type: CustomDialogEnum.warning,
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.greenAccent
            ),
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              "Sair",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green
              )
            ),
          ),
        ],
      ); 
    });
  }

  static void error(String message, BuildContext context) {
    showDialog(context: context, builder: (context) {
      return CustomDialog(
        type: CustomDialogEnum.error,
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.greenAccent
            ),
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              "Fechar",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green
              )
            ),
          ),
        ],
      ); 
    });
  }
}
