import '../../core/usecases/usecase.dart';
import '../repositories/versao_repository.dart';

class GetFindLastVersao extends UseCase<int?, NoParams> {
  VersaoRepository repository;

  GetFindLastVersao(this.repository);

  @override
  Future<int?> call(NoParams params) async {
    return await repository.findLastVersao();
  }
}