import '../../core/usecases/usecase.dart';
import '../entities/versao.dart';
import '../repositories/versao_repository.dart';

class GetFindAllVersao extends UseCase<List<Versao>?, NoParams> {
  final VersaoRepository repository;

  GetFindAllVersao(this.repository);

  @override
  Future<List<Versao>?> call(NoParams params) async {
    return await repository.findAll();
  }
}