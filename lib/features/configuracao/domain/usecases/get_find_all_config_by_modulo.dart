import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/params.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/configuracao_repository.dart';

class GetFindAllConfigByModulo extends UseCase<Map<String, int>, FindAllConfigByModuloParams> {
  ConfiguracaoRepository repository;

  GetFindAllConfigByModulo(this.repository);

  @override
  Future<Result<Failure, Map<String, int>>> call(FindAllConfigByModuloParams params) async {
    return await repository.findAllConfigByModulo(params.modulo);
  }
}

class FindAllConfigByModuloParams extends Params {
  final String modulo;

  FindAllConfigByModuloParams({
    required this.modulo
  });
}