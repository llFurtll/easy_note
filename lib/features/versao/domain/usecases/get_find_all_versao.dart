import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/versao.dart';
import '../repositories/versao_repository.dart';

class GetFindAllVersao extends UseCase<List<Versao>, NoParams> {
  final VersaoRepository repository;

  GetFindAllVersao(this.repository);

  @override
  Future<Result<Failure, List<Versao>>> call(NoParams params) async {
    return await repository.findAll();
  }
}