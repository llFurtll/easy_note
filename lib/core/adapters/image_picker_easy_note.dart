import 'package:image_picker/image_picker.dart';

class ImagePickerEasyNoteOptions {
  const ImagePickerEasyNoteOptions._(this.option);

  final ImageSource option;

  static const camera = ImagePickerEasyNoteOptions._(ImageSource.camera);
  static const gallery = ImagePickerEasyNoteOptions._(ImageSource.gallery);
}

abstract class ImagePickerEasyNote {
  Future<String?> getImage(ImagePickerEasyNoteOptions method);
}

class ImagePickerEasyNoteImpl implements ImagePickerEasyNote {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Future<String?> getImage(ImagePickerEasyNoteOptions method) async {
    try {
      XFile? file = await _imagePicker.pickImage(source: method.option);

      if (file != null) {
        return file.path;
      }
    } catch (_) {
      return null;
    }

    return "";
  }
}