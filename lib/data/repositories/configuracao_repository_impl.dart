import '../../core/exceptions/custom_exceptions.dart';
import '../../core/failures/failures.dart';
import '../../core/result/result.dart';
import '../../domain/entities/configuracao.dart';
import '../../domain/repositories/configuracao_repository.dart';
import '../datasources/configuracao_data_source.dart';
import '../models/configuracao_model.dart';

class ConfiguracaoRepositoryImpl extends ConfiguracaoRepository {
  ConfiguracaoDataSource dataSource;

  ConfiguracaoRepositoryImpl({required this.dataSource});

  @override
  Future<Result<Failure, Map<String, int>>> findAllConfigByModulo(String modulo) async {
    try {
      final result = await dataSource.findAllConfigByModulo(modulo);
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-find-all-config-by-modulo"));
    }
  }

  @override
  Future<Result<Failure, int>> updateConfig(Configuracao configuracao) async {
    try {
      final result = await dataSource.updateConfig(ConfiguracaoModel.fromEntity(configuracao));
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-update-config"));
    }
  }
}