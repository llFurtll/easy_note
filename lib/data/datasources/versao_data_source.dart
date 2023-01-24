import '../../core/exceptions/custom_exceptions.dart';
import '../../core/storage/storage.dart';
import '../models/versao_model.dart';

abstract class VersaoDataSource {
  Future<List<VersaoModel>> findAll();
  Future<int> findLastVersao();
}

class VersaoDataSourceImpl implements VersaoDataSource {
  final storage = StorageImpl();

  @override
  Future<List<VersaoModel>> findAll() async {
    final connection = await storage.getStorage();

    String sql = """
      SELECT ID, VERSAO FROM VERSAO ORDER BY VERSAO
    """;

    try {
      final result = await connection.rawQuery(sql);
      final List<VersaoModel> response = [];

      for (var item in result) {
        response.add(VersaoModel.fromMap(item));
      }

      await connection.close();

      return response;
    } catch (_) {
      throw StorageException("error-find-all-versao");
    }
  }

  @override
  Future<int> findLastVersao() async {
    final connection = await storage.getStorage();

    try {
      String sql = """
        SELECT ID FROM VERSAO ORDER BY VERSAO DESC LIMIT 1
      """;

      List<Map<String, Object?>> result = await connection.rawQuery(sql);

      connection.close();

      return result[0]["id"] as int;
      
    } catch (_) {
      throw StorageException("error-find-last-versao");
    }
  }
}