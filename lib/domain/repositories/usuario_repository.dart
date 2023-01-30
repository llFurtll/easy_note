abstract class UsuarioRepository {
  Future<int?> updateName(String name, int idUsuario);
  Future<String?> getName(int idUsuario);
  Future<String?> getPhoto(int idUsuario);
  Future<int?> updatePhoto(String path, int idUsuario);
}