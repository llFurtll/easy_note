import '../../core/exceptions/custom_exceptions.dart';
import '../../core/storage/storage.dart';

abstract class UsuarioDataSource {
  Future<int> updateName(String name, int idUsuario);
  Future<String> getName(int idUsuario);
  Future<String> getPhoto(int idUsuario);
  Future<int> updatePhoto(String path, int idUsuario);
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
    } finally {
      connection.close();
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

  @override
  Future<String> getPhoto(int idUsuario) async {
      final connection = await storage.getStorage();

    String sql = """
      SELECT PATH_FOTO FROM CONFIGUSER WHERE ID = ?
    """;

    try {
      final result = await connection.rawQuery(sql, [ idUsuario ]);

      connection.close();

      return result.first["nome"] as String;
    } catch (e) {
      throw StorageException("error-get-photo");
    }
  }

  @override
  Future<int> updatePhoto(String path, int idUsuario) async {
    final connection = await storage.getStorage();

    String sql = """
      UPDATE CONFIGUSER SET PATH_FOTO = ? WHERE ID = ?
    """;

    try {
      return await connection.rawUpdate(sql, [ path, idUsuario ]);
    } catch (e) {
      throw StorageException("error-update-photo");
    } finally {
      connection.close();
    }
  }
}