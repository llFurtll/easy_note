import '../../../../core/exceptions/custom_exceptions.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/versao.dart';
import '../../domain/repositories/versao_repository.dart';
import '../datasources/versao_data_source.dart';

class VersaoRepositoryImpl implements VersaoRepository {
  final VersaoDataSource dataSource;

  const VersaoRepositoryImpl({required this.dataSource});

  @override
  Future<Result<Failure, List<Versao>>> findAll() async {
    try {
      final result = await dataSource.findAll();
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-find-all-versao"));
    }
  }

  @override
  Future<Result<Failure, int>> findLastVersao() async {
    try {
      final result = await dataSource.findLastVersao();
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-find-last-versao"));
    }
  }
}