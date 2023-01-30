import '../../core/exceptions/custom_exceptions.dart';
import '../../domain/repositories/usuario_repository.dart';
import '../datasources/usuario_data_source.dart';

class UsuarioRepositoryImpl extends UsuarioRepository {
  final UsuarioDataSource dataSource;

  UsuarioRepositoryImpl({required this.dataSource});

  @override
  Future<int?> updateName(String name, int idUsuario) async {
    try {
      return await dataSource.updateName(name, idUsuario);
    } on StorageException catch (_) {
      return null;
    }
  }

  @override
  Future<String?> getName(int idUsuario) async {
    try {
      return await dataSource.getName(idUsuario);
    } on StorageException catch (_) {
      return null;
    }
  }
}