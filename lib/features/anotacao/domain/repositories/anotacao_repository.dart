import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../entities/anotacao.dart';

abstract class AnotacaoRepository {
  Future<Result<Failure, List<Anotacao>>> findAll(String descricao);
}