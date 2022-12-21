import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/spacer.dart';
import '../controller/home_view_controller.dart';
import '../injection/home_view_injection.dart';

// ignore: must_be_immutable
class AppBarHomeViewWidget extends ScreenWidget<HomeViewController, HomeViewInjection> {
  AppBarHomeViewWidget({super.key, super.context});

  final ValueNotifier isExpanded = ValueNotifier(false);
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _buildAppBar(context);
  }

  ValueListenableBuilder _buildAppBar(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isExpanded,
      builder: (context, value, child) {
        return SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0)
            )
          ),
          expandedHeight: 280.0,
          floating: true,
          pinned: true,
          snap: false,
          forceElevated: true,
          elevation: 5.0,
          flexibleSpace: value ? const SizedBox.shrink() : _buildBody(context)
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool result = controller.verifySize(constraints);

        return FlexibleSpaceBar(
          title: Visibility(
            visible: result,
            child: const Text("Daniel Melonari"),
          ),
          centerTitle: true,
          collapseMode: CollapseMode.parallax,
          background: SafeArea(
            child: Column(
              children: [
                spacer(10.0),
                _buildProfile(context),
                spacer(10.0),
                _buildName(),
                spacer(10.0),
                _buildSearch(context)
              ],
            ),
          )
        );
      },
    );
  }

  Widget _buildProfile(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 58,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 50.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
              ),
              child: Icon(Icons.camera, color: Theme.of(context).primaryColor, size: 30.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildName() {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white
      ),
      onPressed: () {},
      child: Wrap(
        spacing: 10.0,
        alignment: WrapAlignment.center,
        children: const [
          Text(
            "Daniel Melonari",
            style: TextStyle (
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextFormField(
        focusNode: controller.focusNode,
        controller: textController,
        onChanged: (String value) {},
        decoration: const InputDecoration(
          hintText: "Pesquisar anotação",
          suffixIcon: Icon(Icons.search, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.white
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white
            )
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white
            )
          ),
          hintStyle: TextStyle(
            color: Colors.white54
          ),
        ),
        cursorColor: Colors.white,
        style: const TextStyle(
          color: Colors.white
        ),
      ),
    );
  }
}