import 'package:intl/intl.dart';

class ListItemNoteHomeModel {
  final int id;
  final String titulo;
  final String data;
  final String imagemFundo;

  const ListItemNoteHomeModel({
    required this.id,
    required this.titulo,
    required this.data,
    required this.imagemFundo
  });

  factory ListItemNoteHomeModel.fromMap(Map map) {
    return ListItemNoteHomeModel(
      id: map["id"],
      titulo: map["titulo"],
      data: DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.parse(map["data"])),
      imagemFundo: map["imagem_fundo"],
    );
  }
}
