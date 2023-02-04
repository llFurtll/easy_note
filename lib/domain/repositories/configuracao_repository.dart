import '../../core/failures/failures.dart';
import '../../core/result/result.dart';
import '../entities/configuracao.dart';

abstract class ConfiguracaoRepository {
  Future<Result<Failure, Map<String, int>>> findAllConfigByModulo(String modulo);
  Future<Result<Failure, int>> updateConfig(Configuracao configuracao);
}