import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/anotacao.dart';
import '../repositories/anotacao_repository.dart';

class GetSaveAnotacao extends UseCase<Anotacao, SaveAnotacaoParams> {
  AnotacaoRepository repository;

  GetSaveAnotacao(this.repository);

  @override
  Future<Result<Failure, Anotacao>> call(params) async {
    final anotacao = params.anotacao;
    if (anotacao.id == null) {
      return await repository.insert(anotacao);
    } else {
      return await repository.update(anotacao);
    }
  }
}

class SaveAnotacaoParams extends Params {
  final Anotacao anotacao;

  SaveAnotacaoParams({required this.anotacao});
}
