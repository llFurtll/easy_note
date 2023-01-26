import '../../core/exceptions/custom_exceptions.dart';
import '../../domain/repositories/configuracao_repository.dart';
import '../datasources/configuracao_data_source.dart';

class ConfiguracaoRepositoryImpl extends ConfiguracaoRepository {
  ConfiguracaoDataSource dataSource;

  ConfiguracaoRepositoryImpl({required this.dataSource});

  @override
  Future<Map<String, int>?> findAllConfigByModulo(String modulo) async {
    try {
      return await dataSource.findAllConfigByModulo(modulo);
    } on StorageException catch (_) {
      return null;
    }
  }
}