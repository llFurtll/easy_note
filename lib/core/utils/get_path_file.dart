import 'package:path_provider/path_provider.dart';

Future<String> getPath(String destiny) async {
  final pathBase = (await getApplicationDocumentsDirectory()).path;
  final pathFinal = "$pathBase/$destiny";

  return pathFinal;
}