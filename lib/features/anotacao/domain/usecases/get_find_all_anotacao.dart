import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/params.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/anotacao_repository.dart';

class GetFindAllAnotacao extends UseCase<List<Map<String, Object?>>, FindAllAnotacaoParams> {
  AnotacaoRepository repository;

  GetFindAllAnotacao(this.repository);
  
  @override
  Future<Result<Failure, List<Map<String, Object?>>>> call(params) async {
    return await repository.findAll(params.descricao);
  }
}

class FindAllAnotacaoParams extends Params {
  final String descricao;

  FindAllAnotacaoParams({
    required this.descricao
  });  
}