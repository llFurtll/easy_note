import 'package:path_provider/path_provider.dart';

Future<String> getDefaultDir() async {
  return (await getApplicationDocumentsDirectory()).path;
}