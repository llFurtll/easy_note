import '../../core/failures/failures.dart';
import '../../core/result/result.dart';

abstract class UsuarioRepository {
  Future<Result<Failure, int>> updateName(String name, int idUsuario);
  Future<Result<Failure, String>> getName(int idUsuario);
  Future<Result<Failure, String>> getPhoto(int idUsuario);
  Future<Result<Failure, int>> updatePhoto(String path, int idUsuario);
}