
import '../../domain/entities/versao.dart';

class VersaoModel extends Versao {
  const VersaoModel({
    required super.idVersao,
    required super.versao
  });

  factory VersaoModel.fromMap(Map json) {
    return VersaoModel(
      idVersao: json["id"],
      versao: json["versao"]
    );
  }
}