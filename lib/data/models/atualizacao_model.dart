import '../../domain/entities/atualizacao.dart';

class AtualizacaoModel extends Atualizacao {
  const AtualizacaoModel({
    required super.id,
    required super.idVersao,
    required super.cabecalho,
    required super.descricao,
    required super.imagem
  });

  factory AtualizacaoModel.fromMap(Map map) {
    return AtualizacaoModel(
      id: map["id"],
      idVersao: map["id_versao"],
      cabecalho: map["cabecalho"],
      descricao: map["descricao"],
      imagem: map["imagem"]
    );
  }
}