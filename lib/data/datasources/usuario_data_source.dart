import '../../core/exceptions/custom_exceptions.dart';
import '../../core/storage/storage.dart';

abstract class UsuarioDataSource {
  Future<int> updateName(String name, int idUsuario);
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
}