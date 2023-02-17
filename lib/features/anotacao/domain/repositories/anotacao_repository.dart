import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../entities/anotacao.dart';

abstract class AnotacaoRepository {
  Future<Result<Failure, List<Map<String, Object?>>>> findAll(String descricao);
  Future<Result<Failure, Anotacao>> insert(Anotacao anotacao);
  Future<Result<Failure, Anotacao>> update(Anotacao anotacao);
}
