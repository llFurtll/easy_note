import '../../domain/entities/configuracao.dart';

class ConfiguracaoModel extends Configuracao {
  const ConfiguracaoModel({
    required super.id,
    required super.identificador,
    required super.valor,
    required super.modulo
  });

  factory ConfiguracaoModel.fromMap(Map map) {
    return ConfiguracaoModel(
      id: map["id"],
      identificador: map["identificador"],
      valor: map["valor"],
      modulo: map["modulo"]
    );
  }
}