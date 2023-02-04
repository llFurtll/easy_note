import '../../core/failures/failures.dart';
import '../../core/result/result.dart';
import '../../core/usecases/params.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/usuario_repository.dart';

class GetSaveNameUsuario extends UseCase<int, SaveNameUsuarioParams> {
  UsuarioRepository repository;

  GetSaveNameUsuario(this.repository);

  @override
  Future<Result<Failure, int>> call(SaveNameUsuarioParams params) async {
    return await repository.updateName(params.name, params.idUsuario);
  }
  
}

class SaveNameUsuarioParams extends Params {
  final String name;
  final int idUsuario;

  SaveNameUsuarioParams({
    required this.name,
    required this.idUsuario
  });
}