import '../entities/versao.dart';
import '../repositories/versao_repository.dart';

class GetFindAllVersao {
  final VersaoRepository repository;

  const GetFindAllVersao(this.repository);

  Future<List<Versao>?> findAll() async {
    return await repository.findAll();
  }
}