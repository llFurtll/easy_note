import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:screen_manager/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  Widget _buildList() {
    return ValueListenableBuilder(
      valueListenable: controller.isLoadingList,
      builder: (context, value, child) {
        final lista = controller.anotacoes;
        final size = lista.length;

        return SliverFillRemaining(
          child: SmartRefresher(
            header: const WaterDropMaterialHeader(
              color: Colors.white
            ),
            onRefresh: controller.onRefresh,
            controller: controller.refreshController,
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: size > 0 ? size : 1,
              itemBuilder: (context, index) {      
                if (value) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - (280 + kToolbarHeight),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                if (size == 0) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - (280 + kToolbarHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SvgPicture.asset("lib/assets/images/sem-anotacao.svg", width: 100.0, height: 100.0),
                        const Text(
                          "Sem anotações!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.grey
                          ),
                        )
                      ],
                    ),
                  );
                }

                return CardNoteHomeViewWidget(item: lista[index]);
              },
            ),
          ),
        );
      },
    );
  }
}