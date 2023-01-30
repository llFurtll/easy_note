import '../../core/exceptions/custom_exceptions.dart';
import '../../core/storage/storage.dart';

abstract class UsuarioDataSource {
  Future<int> updateName(String name, int idUsuario);
  Future<String> getName(int idUsuario);
}

class UsuarioDataSourceImpl extends UsuarioDataSource {
  final storage = StorageImpl();

  @override
  Future<int> updateName(String name, int idUsuario) async {
    final connection = await storage.getStorage();

    String sql = """
      UPDATE CONFIGUSER SET NOME = ? WHERE ID = ?
    """;

    try {
      return await connection.rawUpdate(sql, [ name, idUsuario ]);
    } catch (_) {
      throw StorageException("error-update-name");
    }
  }

  @override
  Future<String> getName(int idUsuario) async {
    final connection = await storage.getStorage();

    String sql = """
      SELECT NOME FROM CONFIGUSER WHERE ID = ?
    """;

    try {
      final result = await connection.rawQuery(sql, [ idUsuario ]);

      connection.close();

      return result.first["nome"] as String;
    } catch (e) {
      throw StorageException("error-get-name");
    }
  }
}