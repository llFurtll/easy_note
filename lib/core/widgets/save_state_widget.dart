import 'package:flutter/material.dart';

class SaveStateWidget extends StatefulWidget {
  final Widget child;
  
  const SaveStateWidget({super.key, required this.child});

  @override
  SaveStateWidgetState createState() => SaveStateWidgetState();
}

class SaveStateWidgetState extends State<SaveStateWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;

}