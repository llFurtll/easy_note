import '../../core/usecases/params.dart';
import '../../core/usecases/usecase.dart';
import '../entities/anotacao.dart';
import '../repositories/anotacao_repository.dart';

class GetFindAllAnotacao extends UseCase<List<Anotacao>?, FindAllAnotacaoParams> {
  AnotacaoRepository repository;

  GetFindAllAnotacao(this.repository);
  
  @override
  Future<List<Anotacao>?> call(params) async {
    return await repository.findAll(params.descricao);
  }
}

class FindAllAnotacaoParams extends Params {
  final String descricao;

  FindAllAnotacaoParams({
    required this.descricao
  });  
}