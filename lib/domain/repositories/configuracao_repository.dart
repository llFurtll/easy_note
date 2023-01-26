abstract class ConfiguracaoRepository {
  Future<Map<String, int>?> findAllConfigByModulo(String modulo);
}