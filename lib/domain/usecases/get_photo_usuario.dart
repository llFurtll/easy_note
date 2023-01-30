import '../../core/usecases/params.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/usuario_repository.dart';

class GetPhotoUsuario extends UseCase<String?, PhotoUsuarioParams> {
  UsuarioRepository repository;

  GetPhotoUsuario(this.repository);

  @override
  Future<String?> call(PhotoUsuarioParams params) async {
    return await repository.getPhoto(params.idUsuario);
  }
}

class PhotoUsuarioParams extends Params {
  final int idUsuario;

  PhotoUsuarioParams({
    required this.idUsuario
  });
}