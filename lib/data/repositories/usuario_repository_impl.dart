import '../../core/exceptions/custom_exceptions.dart';
import '../../core/failures/failures.dart';
import '../../core/result/result.dart';
import '../../domain/repositories/usuario_repository.dart';
import '../datasources/usuario_data_source.dart';

class UsuarioRepositoryImpl extends UsuarioRepository {
  final UsuarioDataSource dataSource;

  UsuarioRepositoryImpl({required this.dataSource});

  @override
  Future<Result<Failure, int>> updateName(String name, int idUsuario) async {
    try {
      final result = await dataSource.updateName(name, idUsuario);
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-update-name"));
    }
  }

  @override
  Future<Result<Failure, String>> getName(int idUsuario) async {
    try {
      final result = await dataSource.getName(idUsuario);
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-get-name"));
    }
  }

  @override
  Future<Result<Failure, String>> getPhoto(int idUsuario) async {
    try {
      final result = await dataSource.getPhoto(idUsuario);
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-get-photo"));
    }
  }
  @override
  Future<Result<Failure, int>> updatePhoto(String path, int idUsuario) async {
    try {
      final result = await dataSource.updatePhoto(path, idUsuario);
      return Right(result);
    } on StorageException catch (_) {
      return Left(StorageFailure(message: "error-update-photo"));
    }
  }
}