import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/anotacao.dart';
import '../repositories/anotacao_repository.dart';

class GetFindByIdAnotacao extends UseCase<Anotacao, FindByIdAnotacaoParams> {
  AnotacaoRepository repository;

  GetFindByIdAnotacao(this.repository);

  @override
  Future<Result<Failure, Anotacao>> call(params) async {
    return await repository.findById(params.idAnotacao);
  }
}

class FindByIdAnotacaoParams extends Params {
  final int idAnotacao;

  FindByIdAnotacaoParams({required this.idAnotacao});
}
