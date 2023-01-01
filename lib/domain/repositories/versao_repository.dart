import '../entities/versao.dart';

abstract class VersaoRepository {
  Future<List<Versao>?> findAll();
}