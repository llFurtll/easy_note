import '../../../../core/exceptions/custom_exceptions.dart';
import '../../../../core/storage/storage.dart';
import '../models/atualizacao_model.dart';

abstract class AtualizacaoDataSource {
  Future<List<AtualizacaoModel>> findAtualizacoesByVersao(int idVersao);
  Future<bool> existeAtualizacaoWithouView(int idVersao);
}

class AtualizacaoDataSourceImpl implements AtualizacaoDataSource {
  final storage = StorageImpl();

  @override
  Future<List<AtualizacaoModel>> findAtualizacoesByVersao(int idVersao) async {
    final connection = await storage.getStorage();

    String sql = """
      SELECT
        ID,
        ID_VERSAO,
        CABECALHO,
        DESCRICAO,
        IMAGEM
      FROM
        ATUALIZACAO
      WHERE ID_VERSAO = ?
    """;

    try {
      final result = await connection.rawQuery(sql, [ idVersao ]);
      final List<AtualizacaoModel> response = [];

      for (var item in result) {
        response.add(AtualizacaoModel.fromMap(item));
      }

      return response;
    } catch (_) {
      throw StorageException("error-find-atualizacao-by-versao");
    } finally {
      await connection.close();
    }
  }

  @override
  Future<bool> existeAtualizacaoWithouView(int idVersao) async {
    final connection = await storage.getStorage();

    String sql = """
      SELECT
        COUNT(1) AS TOTAL
      FROM ATUALIZACAO
      WHERE ID_VERSAO = ? AND ID_VERSAO NOT IN (
        SELECT ID_VERSAO FROM VISUALIZACAO
      )
    """;

    try {
      List<Map<String, Object?>> result = await connection.rawQuery(sql, [ idVersao ]);
      return result[0]["TOTAL"] as int > 0;
    } catch (_) {
      throw StorageException("error-find-all-by-versao-without-visualizacao");
    } finally {
      await connection.close();
    }
  }
}