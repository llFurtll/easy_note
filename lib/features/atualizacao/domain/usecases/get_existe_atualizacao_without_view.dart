import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/params.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/atualizacao_repository.dart';

class GetExisteAtualizacaoWithoutView extends UseCase<bool, GetExisteAtualizacaoWithoutViewParams> {
  AtualizacaoRepository repository;

  GetExisteAtualizacaoWithoutView(this.repository);

  @override
  Future<Result<Failure, bool>> call(GetExisteAtualizacaoWithoutViewParams params) async {
    return await repository.existeAtualizacaoWithouView(params.idVersao);
  }

}

class GetExisteAtualizacaoWithoutViewParams extends Params {
  final int idVersao;

  GetExisteAtualizacaoWithoutViewParams({
    required this.idVersao
  });
}