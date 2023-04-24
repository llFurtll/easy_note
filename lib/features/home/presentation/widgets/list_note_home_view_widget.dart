import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:rive/rive.dart';
import 'package:screen_manager/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../controller/home_controller.dart';
import 'card_note_home_view_widget.dart';

// ignore: must_be_immutable
class ListNoteHomeViewWidget extends ScreenWidget<HomeController> {
  final double _offsetToArmed = 200 - 250;

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
          child: CustomRefreshIndicator(
            offsetToArmed: _offsetToArmed,
            builder: (_, customChild, innerConroller) {
              return AnimatedBuilder(
                animation: innerConroller,
                child: customChild,
                builder: (_, __) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: _offsetToArmed * innerConroller.value,
                        child: const RiveAnimation.asset(
                          "lib/assets/images/loading_animation.riv",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0.0, _offsetToArmed * innerConroller.value)
                      )
                    ],
                  );
                },
              );
            },
            onRefresh: () async => controller.onRefresh(),
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