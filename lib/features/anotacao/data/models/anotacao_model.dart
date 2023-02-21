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
      id: map["id"],
      titulo: map["titulo"],
      data: DateTime.parse(map["data"]),
      situacao: map["situacao"],
      imagemFundo: map["imagem_fundo"],
      observacao: map["observacao"],
      ultimaAtualizacao: DateTime.parse(map["ultima_atualizacao"])
    );
  }

  factory AnotacaoModel.fromAnotacao(Anotacao anotacao) {
    return AnotacaoModel(
      id: anotacao.id,
      titulo: anotacao.titulo,
      data: anotacao.data,
      situacao: anotacao.situacao,
      imagemFundo: anotacao.imagemFundo,
      observacao: anotacao.observacao,
      ultimaAtualizacao: anotacao.ultimaAtualizacao,
    );
  }

  Map<String, dynamic> toMap(bool insert) {
    final result = <String, dynamic>{};

    result.addAll(
      {
        "id": id,
        "titulo": titulo, 
        "data": data?.toIso8601String(),
        "situacao": situacao,
        "imagem_fundo": imagemFundo,
        "OBSERVACAO": observacao,
        "ultima_atualizacao": ultimaAtualizacao?.toIso8601String()
      }
    );

    if (insert) {
      result.remove("id");
    }

    return result;
  }
}