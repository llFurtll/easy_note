abstract class Failure {
  final String message;

  const Failure({
    required this.message
  });
}

class StorageFailure extends Failure {
  StorageFailure({required super.message});
}