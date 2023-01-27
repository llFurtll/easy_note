
import '../../core/usecases/params.dart';
import '../../core/usecases/usecase.dart';
import '../entities/configuracao.dart';
import '../repositories/configuracao_repository.dart';

class GetSaveConfiguracao extends UseCase<int?, SaveConfiguracaoParams> {
  ConfiguracaoRepository repository;

  GetSaveConfiguracao(this.repository);

  @override
  Future<int?> call(SaveConfiguracaoParams params) async {
    return await repository.updateConfig(params.configuracao);
  }
}

class SaveConfiguracaoParams extends Params {
  final Configuracao configuracao;

  SaveConfiguracaoParams({
    required this.configuracao
  });
}