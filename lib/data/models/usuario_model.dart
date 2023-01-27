import '../../domain/entities/usuario.dart';

class UsuarioModel extends Usuario {
  const UsuarioModel({
    required super.id,
    required super.pathFoto,
    required super.nome,
  });

  factory UsuarioModel.fromMap(Map map) {
    return UsuarioModel(
      id: map["id"],
      pathFoto: map["path_foto"],
      nome: map["nome"]
    );
  }
}