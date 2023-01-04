import 'params.dart';

abstract class UseCase<T, P extends Params> {
  Future<T> call(P params);
}

class NoParams extends Params {}