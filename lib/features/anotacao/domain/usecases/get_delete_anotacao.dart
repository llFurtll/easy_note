import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/params.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/anotacao_repository.dart';

class GetDeleteAnotacao extends UseCase<int, DeleteAnotacaoParams> {
  AnotacaoRepository repository;

  GetDeleteAnotacao(this.repository);

  @override
  Future<Result<Failure, int>> call(params) async {
    return await repository.delete(params.idAnotacao);
  }
}

class DeleteAnotacaoParams extends Params {
  final int idAnotacao;

  DeleteAnotacaoParams({required this.idAnotacao});
}
