import '../../../../core/exceptions/custom_exceptions.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/atualizacao.dart';
import '../../domain/repositories/atualizacao_repository.dart';
import '../datasources/atualizacao_data_source.dart';

class AtualizacaoRepositoryImpl implements AtualizacaoRepository {
  final AtualizacaoDataSource dataSource;

  const AtualizacaoRepositoryImpl({required this.dataSource});

  @override
  Future<Result<Failure, List<Atualizacao>>> findAtualizacoesByVersao(int idVersao) async {
    try {
      final result = await dataSource.findAtualizacoesByVersao(idVersao);
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-find-atualizacao-by-versao"));
    }
  }

  @override
  Future<Result<Failure, bool>> existeAtualizacaoWithouView(int idVersao) async {
    try {
      final result = await dataSource.existeAtualizacaoWithouView(idVersao);
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-existe-atualizacao-without-view"));
    }
  }
}