import 'dart:io';

import 'package:screen_manager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/spacer.dart';
import '../controller/home_controller.dart';

// ignore: must_be_immutable
class AppBarHomeViewWidget extends ScreenWidget<HomeController> {
  const AppBarHomeViewWidget({super.key, super.context});

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _buildAppBar(context);
  }

  SliverAppBar _buildAppBar(BuildContext context) {
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
      flexibleSpace: _buildBody(context),
      actions: _buildActions(),
    );
  }

  List<Widget> _buildActions() {
    return [
      _buildPopup()
    ];
  }

  PopupMenuButton _buildPopup() {
    return PopupMenuButton<int>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      tooltip: "Menu",
      itemBuilder: (BuildContext context) => const [
        PopupMenuItem(
          value: 1,
          child: Text("Configurações"),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 2,
          child: Text("Sobre o desenvolvedor")
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 3,
          child: Text("O que há de novo?")
        )
      ],
      onSelected: (int index) {
        switch (index) {
          case 2:
            controller.toSobre();
            break;
          case 3:
            controller.toNovo();
            break;
          default:
            controller.toConfiguracao();
        }
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool result = controller.verifySize(constraints);
        final name = controller.nameUser.value;

        return FlexibleSpaceBar(
          title: Visibility(
            visible: result,
            child: Text(name.isEmpty ? "Digite seu nome aqui :)" : name)
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
    return GestureDetector(
      onTap: controller.showAlterPhoto,
      child: ValueListenableBuilder(
        valueListenable: controller.photoUser,
        builder: (context, value, child) {
          final path = value;

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            width: 120.0,
            height: 120.0,
            child: Stack(
              children: [
                ClipOval(
                  child: SizedBox(
                    child: Image.file(
                      File(path),
                      gaplessPlayback: true,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                        return AnimatedSwitcher(
                          duration: Duration(
                            milliseconds: !controller.fotoPerfilCarregada ? 500 : 0
                          ),
                          child: frame == null && !controller.fotoPerfilCarregada ?
                            const Center(child: CircularProgressIndicator()) :
                            () {
                              controller.fotoPerfilCarregada = true;
                              return child;
                            }() 
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text(
                            "SEM FOTO",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        );
                      },
                    ),
                  )
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 50.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                    ),
                    child: Icon(Icons.camera, color: Theme.of(context).primaryColor, size: 30.0),
                  )
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildName() {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white
      ),
      onPressed: controller.showAlterName,
      child: Wrap(
        spacing: 10.0,
        alignment: WrapAlignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: controller.nameUser,
            builder: (context, value, child) => Text(
              value.isEmpty ? "Digite seu nome aqui :)" : value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            ),
          ),
          const Icon(
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
        controller: controller.textController,
        onChanged: controller.onSearch,
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