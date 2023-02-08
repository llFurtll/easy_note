import '../../../../core/failures/failures.dart';
import '../../../../core/result/result.dart';
import '../../../../core/usecases/params.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/usuario_repository.dart';

class GetNameUsuario extends UseCase<String, NameUsuarioParams> {
  UsuarioRepository repository;

  GetNameUsuario(this.repository);

  @override
  Future<Result<Failure, String>> call(NameUsuarioParams params) async {
    return await repository.getName(params.idUsuario);
  }
}

class NameUsuarioParams extends Params {
  final int idUsuario;

  NameUsuarioParams({
    required this.idUsuario
  });
}