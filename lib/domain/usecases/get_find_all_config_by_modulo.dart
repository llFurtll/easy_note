import '../../core/usecases/params.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/configuracao_repository.dart';

class GetFindAllConfigByModulo extends UseCase<Map<String, int>?, FindAllConfigByModulo> {
  ConfiguracaoRepository repository;

  GetFindAllConfigByModulo(this.repository);

  @override
  Future<Map<String, int>?> call(FindAllConfigByModulo params) async {
    return await repository.findAllConfigByModulo(params.modulo);
  }
}

class FindAllConfigByModulo extends Params {
  final String modulo;

  FindAllConfigByModulo({
    required this.modulo
  });
}