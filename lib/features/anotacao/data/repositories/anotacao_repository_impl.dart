import '../../../../core/exceptions/custom_exceptions.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/anotacao.dart';
import '../../domain/repositories/anotacao_repository.dart';
import '../datasources/anotacao_data_source.dart';
import '../models/anotacao_model.dart';

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

  @override
  Future<Result<Failure, Anotacao>> insert(Anotacao anotacao) async {
    try {
      final result = await dataSource.insert(
        AnotacaoModel.fromAnotacao(anotacao)
      );
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-insert-anotacao"));
    }
  }

  @override
  Future<Result<Failure, Anotacao>> update(Anotacao anotacao) async {
    try {
      final result = await dataSource.update(
        AnotacaoModel.fromAnotacao(anotacao)
      );
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-update-anotacao"));
    }
  }
}
