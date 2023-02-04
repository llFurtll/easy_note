import '../../core/failures/failures.dart';
import '../../core/result/result.dart';
import '../entities/atualizacao.dart';

abstract class AtualizacaoRepository {
  Future<Result<Failure, List<Atualizacao>>> findAtualizacoesByVersao(int idVersao);
  Future<Result<Failure, bool>> existeVersaoWithoutView(int idVersao);
}