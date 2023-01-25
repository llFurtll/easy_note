import '../../core/exceptions/custom_exceptions.dart';
import '../../domain/entities/anotacao.dart';
import '../../domain/repositories/anotacao_repository.dart';
import '../datasources/anotacao_data_source.dart';

class AnotacaoRepositoryImpl extends AnotacaoRepository {
  AnotacaoDataSource dataSource;

  AnotacaoRepositoryImpl({required this.dataSource});

  @override
  Future<List<Anotacao>?> findAll(String descricao) async {
    try {
      return await dataSource.findAll(descricao);
    } on StorageException catch (_) {
      return null;
    }
  }
}