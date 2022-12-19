import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../controller/home_view_controller.dart';
import '../injection/home_view_injection.dart';

// ignore: must_be_immutable
class ListNoteHomeViewWidget extends ScreenWidget<HomeViewController, HomeViewInjection> {
  ListNoteHomeViewWidget({super.key, super.context});

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return _buildList();
  }

  SliverList _buildList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Text("NOTA $index"),
        childCount: 50
      ),
    );
  }
}