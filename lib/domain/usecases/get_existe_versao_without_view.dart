import '../../core/failures/failures.dart';
import '../../core/result/result.dart';
import '../../core/usecases/params.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/atualizacao_repository.dart';

class GetExisteVersaoWithoutView extends UseCase<bool, GetExisteVersaoWithoutViewParams> {
  AtualizacaoRepository repository;

  GetExisteVersaoWithoutView(this.repository);

  @override
  Future<Result<Failure, bool>> call(GetExisteVersaoWithoutViewParams params) async {
    return await repository.existeVersaoWithoutView(params.idVersao);
  }

}

class GetExisteVersaoWithoutViewParams extends Params {
  final int idVersao;

  GetExisteVersaoWithoutViewParams({
    required this.idVersao
  });
}