import 'package:flutter/services.dart';

import '../../../../core/exceptions/custom_exceptions.dart';
import '../../../../core/storage/storage.dart';
import '../models/anotacao_model.dart';

abstract class AnotacaoDataSource {
  Future<List<Map<String, Object?>>> findAll(String descricao);
  Future<AnotacaoModel> insert(AnotacaoModel anotacao);
  Future<AnotacaoModel> update(AnotacaoModel anotacao);
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
      List<Map<String, Object?>> listNote = await connection.rawQuery(sqlFinal);
      List<Map<String, Object?>> result = [];

      for (Map<String, Object?> map in listNote) {
        final tmpMap = Map<String, Object>.from(map);
        final path = tmpMap["imagem_fundo"] as String;
        if (path.isNotEmpty && path.contains("lib")) {
          final bytesData = await rootBundle.load(path);
          final buffer = bytesData.buffer.asUint8List();
          tmpMap["imagem_fundo"] = buffer;
        } else {
          tmpMap["imagem_fundo"] = Uint8List(0);
        }
        result.add(tmpMap);
      }

      await connection.close();

      return result;
    } catch (_) {
      throw StorageException("error-find-all");
    }
  }

  @override
  Future<AnotacaoModel> insert(AnotacaoModel anotacao) async {
    try {
      final connection = await storage.getStorage();
      final map = anotacao.toMap(true);

      int insert = await connection.insert("NOTE", map);

      await connection.close();

      if (insert == 0) {
        throw StorageException("");
      }

      map["ID"] = insert;
      anotacao = AnotacaoModel.fromMap(map);
      return anotacao;
    } catch (_) {
      throw StorageException("error-insert-anotacao");
    }
  }

  @override
  Future<AnotacaoModel> update(AnotacaoModel anotacao) async {
    try {
      final connection = await storage.getStorage();
      final map = anotacao.toMap(false);

      int update = await connection
          .update("NOTE", map, where: "ID = ?", whereArgs: [anotacao.id]);

      await connection.close();

      if (update == 0) {
        throw StorageException("");
      }

      return anotacao;
    } catch (_) {
      throw StorageException("error-update-anotacao");
    }
  }
}
