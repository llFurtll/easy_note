import '../../features/anotacao/domain/entities/anotacao.dart';
import '../enum/type_share.dart';

class ShareAnotacaoArguments {
  final Anotacao anotacao;
  final bool showImage;
  final TypeShare typeShare;

  const ShareAnotacaoArguments({
    required this.anotacao,
    required this.showImage,
    required this.typeShare
  });
}