import '../entities/atualizacao.dart';

abstract class AtualizacaoRepository {
  Future<List<Atualizacao>?> findAtualizacoesByVersao(int idVersao);
  Future<bool?> existeVersaoWithoutView(int idVersao);
}