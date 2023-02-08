import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../entities/versao.dart';

abstract class VersaoRepository {
  Future<Result<Failure, List<Versao>>> findAll();
  Future<Result<Failure, int>> findLastVersao();
}