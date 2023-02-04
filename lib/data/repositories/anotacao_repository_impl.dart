import '../../core/exceptions/custom_exceptions.dart';
import '../../core/failures/failures.dart';
import '../../core/result/result.dart';
import '../../domain/entities/anotacao.dart';
import '../../domain/repositories/anotacao_repository.dart';
import '../datasources/anotacao_data_source.dart';

class AnotacaoRepositoryImpl extends AnotacaoRepository {
  AnotacaoDataSource dataSource;

  AnotacaoRepositoryImpl({required this.dataSource});

  @override
  Future<Result<Failure, List<Anotacao>>> findAll(String descricao) async {
    try {
      final result = await dataSource.findAll(descricao);
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-find-all-anotacao"));
    }
  }
}