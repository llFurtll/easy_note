import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/widgets/spacer.dart';
import '../controller/home_view_controller.dart';
import '../injection/home_view_injection.dart';

// ignore: must_be_immutable
class CardNoteHomeViewWidget extends ScreenWidget<HomeViewController, HomeViewInjection> {
  final int id;

  CardNoteHomeViewWidget({super.key, super.context, required this.id});
  
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: _buildCard(context),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    const shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const StretchMotion(),
        children: [
          Flexible(
            child: Center(
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                onTap: () {},
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      color: Colors.red
                    ),
                    width: 70,
                    height: 70,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
            )
          )
        ],
      ),
      child: InkWell(
        onTap: () {},
        customBorder: shape,
        child: Card(
          shape: shape,
          clipBehavior: Clip.antiAlias,
          elevation: 10.0,
          child: Container( // IMAGEM DE FUNDO
            height: 90.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://www.akamai.com/site/im-demo/perceptual-standard.jpg?imbypass=true"),
                fit: BoxFit.cover
              )
            ),
            child: Container( // SOMBRA
              color: Colors.white.withOpacity(0.5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  spacer(10.0),
                  _buildTitle(),
                  spacer(10.0),
                  _buildFooter()
                ],
              ),
            )
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text(
        "NOTA - $id",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      height: 35.0,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10.0),
      width: double.infinity,
      color: Colors.grey[400],
      child: Text(
        DateTime.now().toString(),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}