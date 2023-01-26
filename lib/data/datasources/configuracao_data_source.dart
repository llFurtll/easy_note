import '../../core/exceptions/custom_exceptions.dart';
import '../../core/storage/storage.dart';
import '../models/configuracao_model.dart';

abstract class ConfiguracaoDataSource {
  Future<Map<String, int>> findAllConfigByModulo(String modulo);
}

class ConfiguracaoDataSourceImpl extends ConfiguracaoDataSource {
  final storage = StorageImpl();

  @override
  Future<Map<String, int>> findAllConfigByModulo(String modulo) async {
    final connection = await storage.getStorage();

    String sql = """
      SELECT * FROM CONFIGAPP WHERE MODULO = ?
    """;

    try {
      Map<String, int> response = {};

      List<Map> result = await connection.rawQuery(sql, [ modulo ]);

      for (var item in result) {
        final config = ConfiguracaoModel.fromMap(item);
        if (config.identificador != null && config.valor != null) {
          response[config.identificador!] = config.valor!;
        }
      }

      connection.close();

      return response;
    } catch (_) {
      throw StorageException("error-find-all-config-by-modulo");
    }
  }
}