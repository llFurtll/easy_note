import 'package:speech_to_text/speech_to_text.dart';

abstract class SpeechTextEasyNote {
  Future<void> start(Function(String value) onResult);
  Future<void> stop();
  Future<bool> init();
}

class SpeechTextEasyNoteImpl extends SpeechTextEasyNote {
  final _speech = SpeechToText();

  @override
  Future<bool> init() async {
    try {
      return await _speech.initialize();
    } catch (_) {
      return false;
    }
  }
  
  @override
  Future<void> start(Function(String value) onResult) async {
    await _speech.listen(
      onResult: (result) => onResult(result.recognizedWords)
    );
  }

  @override
  Future<void> stop() async {
    await _speech.stop();
  }
}