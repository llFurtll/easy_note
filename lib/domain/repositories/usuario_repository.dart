abstract class UsuarioRepository {
  Future<int?> updateName(String name, int idUsuario);
  Future<String?> getName(int idUsuario);
}