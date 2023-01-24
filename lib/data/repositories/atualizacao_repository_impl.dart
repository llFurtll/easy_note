import '../../core/exceptions/custom_exceptions.dart';
import '../../domain/entities/atualizacao.dart';
import '../../domain/repositories/atualizacao_repository.dart';
import '../datasources/atualizacao_data_source.dart';

class AtualizacaoRepositoryImpl implements AtualizacaoRepository {
  final AtualizacaoDataSource dataSource;

  const AtualizacaoRepositoryImpl({required this.dataSource});

  @override
  Future<List<Atualizacao>?> findAtualizacoesByVersao(int idVersao) async {
    try {
      return await dataSource.findAtualizacoesByVersao(idVersao);
    } on StorageException catch (_) {
      return null;
    }
  }

  @override
  Future<bool?> existeVersaoWithoutView(int idVersao) async {
    try {
      return await dataSource.existeVersaoWithoutView(idVersao);
    } on StorageException catch (_) {
      return null;
    }
  }
}