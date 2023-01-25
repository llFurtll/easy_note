import '../../core/exceptions/custom_exceptions.dart';
import '../../core/storage/storage.dart';

abstract class VisualizacaoDataSource {
  Future<int> insertVisualizacao(int idUsuario, int idVersao);
}

class VisualizacaoDataSourceImpl extends VisualizacaoDataSource {
  final storageImpl = StorageImpl();

  @override
  Future<int> insertVisualizacao(int idUsuario, int idVersao) async {
    final connection = await storageImpl.getStorage();

    try {
      String sql = """
        INSERT INTO VISUALIZACAO (ID_USUARIO, ID_VERSAO)
        VALUES (?, ?)
      """;

      int insert = await connection.rawInsert(sql, [ idUsuario, idVersao ]);

      connection.close();

      return insert;
    } catch (_) {
      throw StorageException("error-insert-visualizacao");
    }
  }

}