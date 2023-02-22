import '../../../../core/exceptions/custom_exceptions.dart';
import '../../../../core/storage/storage.dart';
import '../models/anotacao_model.dart';

abstract class AnotacaoDataSource {
  Future<List<Map<String, Object?>>> findAll(String descricao);
  Future<AnotacaoModel> insert(AnotacaoModel anotacao);
  Future<AnotacaoModel> update(AnotacaoModel anotacao);
  Future<AnotacaoModel> findById(int idAnotacao);
  Future<int> delete(int idAnotcao);
}

class AnotacaoDataSourceImpl extends AnotacaoDataSource {
  final storage = StorageImpl();

  @override
  Future<List<Map<String, Object?>>> findAll(String descricao) async {
    final connection = await storage.getStorage();

    String sql = """
      SELECT
        ID,
        TITULO,
        DATA,
        IMAGEM_FUNDO
      FROM NOTE
      WHERE SITUACAO = 1
    """;

    String sqlLike = "AND TITULO LIKE '%$descricao%'";

    String sqlOrderBy = "ORDER BY DATA DESC";

    String sqlFinal = sql;

    if (descricao.isNotEmpty) {
      sqlFinal += "\n$sqlLike";
    }

    sqlFinal += "\n$sqlOrderBy";

    try {
      return await connection.rawQuery(sqlFinal);
    } catch (_) {
      throw StorageException("error-find-all");
    } finally {
      await connection.close();
    }
  }

  @override
  Future<AnotacaoModel> insert(AnotacaoModel anotacao) async {
    final connection = await storage.getStorage();

    try {
      final map = anotacao.toMap(true);

      int insert = await connection.insert("NOTE", map);

      await connection.close();

      if (insert == 0) {
        throw StorageException("");
      }

      map["id"] = insert;
      anotacao = AnotacaoModel.fromMap(map);
      return anotacao;
    } catch (_) {
      throw StorageException("error-insert-anotacao");
    } finally {
      await connection.close();
    }
  }

  @override
  Future<AnotacaoModel> update(AnotacaoModel anotacao) async {
    final connection = await storage.getStorage();

    try {
      final map = anotacao.toMap(false);

      int update = await connection
          .update("NOTE", map, where: "ID = ?", whereArgs: [anotacao.id]);

      if (update == 0) {
        throw StorageException("");
      }

      return anotacao;
    } catch (_) {
      throw StorageException("error-update-anotacao");
    } finally {
      await connection.close();
    }
  }

  @override
  Future<AnotacaoModel> findById(int idAnotacao) async {
    final storage = StorageImpl();
    final connection = await storage.getStorage();

    String sql = """
      SELECT
        ID,
        TITULO,
        DATA,
        SITUACAO,
        IMAGEM_FUNDO,
        OBSERVACAO,
        ULTIMA_ATUALIZACAO
      FROM NOTE
      WHERE ID = ?
    """;

    try {
      final result = await connection.rawQuery(sql, [idAnotacao]);

      if (result.isEmpty) {
        throw StorageException("error-find-by-id-anotacao");
      }

      return AnotacaoModel.fromMap(result[0]);
    } on StorageException catch (_) {
      rethrow;
    } catch (_) {
      throw StorageException("error-find-by-id-anotacao");
    } finally {
      await connection.close();
    }
  }

  @override
  Future<int> delete(int idAnotcao) async {
    final connection = await storage.getStorage();

    try {
      int update = await connection
          .delete("NOTE", where: "ID = ?", whereArgs: [ idAnotcao ]);

      if (update == 0) {
        throw StorageException("");
      }

      return update;
    } catch (_) {
      throw StorageException("error-delete-anotacao");
    } finally {
      await connection.close();
    }
  }
}
