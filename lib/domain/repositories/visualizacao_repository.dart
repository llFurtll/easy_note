import '../../core/failures/failures.dart';
import '../../core/result/result.dart';

abstract class VisualizacaoRepository {
  Future<Result<Failure, int>> insertVisualizacao(int idUsuario, int idVersao);
}