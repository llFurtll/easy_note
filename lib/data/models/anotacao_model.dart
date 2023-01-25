import '../../domain/entities/anotacao.dart';

class AnotacaoModel extends Anotacao {
  const AnotacaoModel({
    required super.id,
    required super.titulo,
    required super.data,
    required super.situacao,
    required super.imagemFundo,
    required super.observacao,
    required super.ultimaAtualizacao
  });

  factory AnotacaoModel.fromMap(Map map) {
    return AnotacaoModel(
      id: map["ID"],
      titulo: map["TITULO"],
      data: map["DATA"],
      situacao: map["SITUACAO"],
      imagemFundo: map["IMAGEMFUNDO"],
      observacao: map["OBSERVACAO"],
      ultimaAtualizacao: map["ULTIMAATUALIZACAO"]
    );
  }
}