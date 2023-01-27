import '../entities/configuracao.dart';

abstract class ConfiguracaoRepository {
  Future<Map<String, int>?> findAllConfigByModulo(String modulo);
  Future<int?> updateConfig(Configuracao configuracao);
}