import '../../../../core/exceptions/custom_exceptions.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../domain/repositories/visualizacao_repository.dart';
import '../datasources/visualizacao_data_source.dart';

class VisualizacaoRepositoryImpl extends VisualizacaoRepository {
  final VisualizacaoDataSource dataSource;

  VisualizacaoRepositoryImpl({required this.dataSource});

  @override
  Future<Result<Failure, int>> insertVisualizacao(int idUsuario, int idVersao) async {
    try {
      final result = await dataSource.insertVisualizacao(idUsuario, idVersao);
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-insert-visualizacao"));
    }
  }
}