import '../../core/exceptions/custom_exceptions.dart';
import '../../domain/entities/versao.dart';
import '../../domain/repositories/versao_repository.dart';
import '../datasources/versao_data_source.dart';

class VersaoRepositoryImpl implements VersaoRepository {
  final VersaoDataSource dataSource;

  const VersaoRepositoryImpl({required this.dataSource});

  @override
  Future<List<Versao>?> findAll() async {
    try {
      return await dataSource.findAll();
    } on StorageException catch (_) {
      return null;
    }
  }
}