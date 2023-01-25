class Anotacao {
  final int? id;
  final int? titulo;
  final DateTime? data;
  final int? situacao;
  final String? imagemFundo;
  final String? observacao;
  final DateTime? ultimaAtualizacao;

  const Anotacao({
    required this.id,
    required this.titulo,
    required this.data,
    required this.situacao,
    required this.imagemFundo,
    required this.observacao,
    required this.ultimaAtualizacao
  });
}