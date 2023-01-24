import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../controller/home_controller.dart';
import 'card_note_home_view_widget.dart';

// ignore: must_be_immutable
class ListNoteHomeViewWidget extends ScreenWidget<HomeController> {
  const ListNoteHomeViewWidget({super.key, super.context});

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return _buildList();
  }

  SliverPadding _buildList() {
    return SliverPadding(
      padding: const EdgeInsets.all(10.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => CardNoteHomeViewWidget(id: index),
          childCount: 50
        ),
      )
    );
  }
}