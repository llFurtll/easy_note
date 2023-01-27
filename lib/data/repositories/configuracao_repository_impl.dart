import '../../core/exceptions/custom_exceptions.dart';
import '../../domain/entities/configuracao.dart';
import '../../domain/repositories/configuracao_repository.dart';
import '../datasources/configuracao_data_source.dart';
import '../models/configuracao_model.dart';

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

  @override
  Future<int?> updateConfig(Configuracao configuracao) async {
    try {
      return await dataSource.updateConfig(ConfiguracaoModel.fromEntity(configuracao));
    } on StorageException catch (_) {
      return null;
    }
  }
}