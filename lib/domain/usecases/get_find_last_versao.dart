import '../../core/failures/failures.dart';
import '../../core/result/result.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/versao_repository.dart';

class GetFindLastVersao extends UseCase<int, NoParams> {
  VersaoRepository repository;

  GetFindLastVersao(this.repository);

  @override
  Future<Result<Failure, int>> call(NoParams params) async {
    return await repository.findLastVersao();
  }
}