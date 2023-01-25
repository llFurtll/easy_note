import '../../core/exceptions/custom_exceptions.dart';
import '../../domain/repositories/visualizacao_repository.dart';
import '../datasources/visualizacao_data_source.dart';

class VisualizacaoRepositoryImpl extends VisualizacaoRepository {
  final VisualizacaoDataSource dataSource;

  VisualizacaoRepositoryImpl({required this.dataSource});

  @override
  Future<int?> insertVisualizacao(int idUsuario, int idVersao) async {
    try {
      return await dataSource.insertVisualizacao(idUsuario, idVersao);
    } on StorageException catch (_) {
      return null;
    }
  }
}