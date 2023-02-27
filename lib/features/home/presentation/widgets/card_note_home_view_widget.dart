import 'dart:io';

import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../core/widgets/spacer.dart';
import '../controller/home_controller.dart';
import '../models/list_item_note_home_model.dart';

// ignore: must_be_immutable
class CardNoteHomeViewWidget extends ScreenWidget<HomeController> {
  final ListItemNoteHomeModel item;

  const CardNoteHomeViewWidget({super.key, super.context, required this.item});
  
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
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      child: InkWell(
        onTap: () => controller.toEdit(item.id),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 10.0,
          child: Slidable(
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                  onPressed: (BuildContext context) =>
                    controller.removeAnotacao(item)
                )
              ],
            ),
            child: Container( // IMAGEM DE FUNDO
            decoration: BoxDecoration(
              image: item.imagemFundo.isNotEmpty ? DecorationImage(
                image: item.imagemFundo.contains("lib") ?
                  AssetImage(item.imagemFundo) :
                  FileImage(File(item.imagemFundo)) as ImageProvider,
                fit: BoxFit.cover
              ) : null
            ),
            child: Container( // SOMBRA
              constraints: const BoxConstraints(
                minHeight: 90.0
              ),
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
          )
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text(
        item.titulo,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        maxLines: null,
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
        item.data,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}