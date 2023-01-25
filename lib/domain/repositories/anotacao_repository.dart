import '../entities/anotacao.dart';

abstract class AnotacaoRepository {
  Future<List<Anotacao>?> findAll(String descricao);
}