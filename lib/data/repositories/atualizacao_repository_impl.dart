import '../../core/exceptions/custom_exceptions.dart';
import '../../domain/entities/atualizacao.dart';
import '../../domain/repositories/atualizacao_repository.dart';
import '../datasources/atualizacao_data_source.dart';

class AtualizacaoRepositoryImpl implements AtualizacaoRepository {
  final AtualizacaoDataSource dataSource;

  const AtualizacaoRepositoryImpl(this.dataSource);

  @override
  Future<List<Atualizacao>?> findAtualizacoesByVersao(int idVersao) async {
    try {
      return await dataSource.findAtualizacoesByVersao(idVersao);
    } on StorageException catch (_) {
      return null;
    }
  }
}