import '../../core/usecases/params.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/usuario_repository.dart';

class GetSavePhotoUsuario extends UseCase<int?, SavePhotoUsuarioParams> {
  UsuarioRepository repository;

  GetSavePhotoUsuario(this.repository);

  @override
  Future<int?> call(SavePhotoUsuarioParams params) async {
    return await repository.updatePhoto(params.path, params.idUsuario);
  }
}

class SavePhotoUsuarioParams extends Params {
  final String path;
  final int idUsuario;

  SavePhotoUsuarioParams({
    required this.path,
    required this.idUsuario
  });
}