import '../../core/usecases/params.dart';
import '../../core/usecases/usecase.dart';
import '../entities/atualizacao.dart';
import '../repositories/atualizacao_repository.dart';

class GetFindAtualizacaoByVersao extends UseCase<List<Atualizacao>?, FindAtualizacaoByVersaoParams> {
  final AtualizacaoRepository repository;

  GetFindAtualizacaoByVersao(this.repository);

  @override
  Future<List<Atualizacao>?> call(FindAtualizacaoByVersaoParams params) async {
    return await repository.findAtualizacoesByVersao(params.idVersao);
  }
}

class FindAtualizacaoByVersaoParams extends Params {
  final int idVersao;

  FindAtualizacaoByVersaoParams({
    required this.idVersao
  });
}