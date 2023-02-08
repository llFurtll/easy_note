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
  
  factory ConfiguracaoModel.fromEntity(Configuracao configuracao) {
    return ConfiguracaoModel(
      id: configuracao.id,
      identificador: configuracao.identificador,
      valor: configuracao.valor,
      modulo: configuracao.modulo
    );
  }
}