import 'package:uni_links/uni_links.dart';

abstract class DeepLinkEasyNote {
  Future<Uri?> getLink();
}

class DeepLinkEasyNoteImpl extends DeepLinkEasyNote {
  @override
  Future<Uri?> getLink() async {
    final link = await getInitialUri();

    if (link != null) {
      return link;
    }

    return null;
  }
}