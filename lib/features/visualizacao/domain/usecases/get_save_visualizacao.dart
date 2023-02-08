import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/params.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/visualizacao_repository.dart';

class GetSaveVisualizacao extends UseCase<int, SaveVisualizacaoParams> {
  VisualizacaoRepository repository;

  GetSaveVisualizacao(this.repository);
  
  @override
  Future<Result<Failure, int>> call(SaveVisualizacaoParams params) async {
    return await repository.insertVisualizacao(params.idUsuario, params.idVersao);
  }
}

class SaveVisualizacaoParams extends Params {
  final int idUsuario;
  final int idVersao;

  SaveVisualizacaoParams({
    required this.idUsuario,
    required this.idVersao
  });
}